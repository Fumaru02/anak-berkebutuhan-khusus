import 'dart:developer';
import 'dart:io';

import 'package:anak_berkebutuhan_khusus/helper/ontap_identifier.dart';
import 'package:anak_berkebutuhan_khusus/models/education_model.dart';
import 'package:anak_berkebutuhan_khusus/models/history_model.dart';
import 'package:anak_berkebutuhan_khusus/view/history_view.dart';
import 'package:anak_berkebutuhan_khusus/view/home_view.dart';
import 'package:anak_berkebutuhan_khusus/view/profile_view.dart';
import 'package:anak_berkebutuhan_khusus/view/quisoner/quisoner_view.dart';
import 'package:anak_berkebutuhan_khusus/view/welcome_view.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/login_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FrameController extends GetxController {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt defaultIndex = RxInt(0);
  RxInt unReadNotif = RxInt(0);
  final RxBool isLoading = false.obs;
  final RxBool isEdit = false.obs;
  // User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  TextEditingController usernameChange = TextEditingController();
  TextEditingController noHPChange = TextEditingController();
  // final CarouselSliderController carouselController =
  //     CarouselSliderController();
  TextEditingController emailChange = TextEditingController();
  final RxInt currentDot = RxInt(0);
  File? image;
  RxString userName = RxString('');
  RxString userImage = RxString('');
  final RxString errorMessage = ''.obs;
  RxString phoneNumber = RxString('');
  RxList<EducationModel> educationsList = RxList<EducationModel>(
    <EducationModel>[],
  );
  final TextEditingController passwordController = TextEditingController();

  RxList<HistoryModel> historyList = RxList<HistoryModel>(<HistoryModel>[]);
  RxString userEmail = RxString('');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final User? user = FirebaseAuth.instance.currentUser;
  RxList<OnTapIdentifier> onTapIdentifierList =
      RxList<OnTapIdentifier>(<OnTapIdentifier>[
        OnTapIdentifier(name: '', index: 0, isOnTapped: true),
        OnTapIdentifier(name: '', index: 1, isOnTapped: false),
        OnTapIdentifier(name: '', index: 2, isOnTapped: false),
      ]);
  @override
  void onInit() async {
    await getEducations();
    await getDataUser();
    await getHistory(userName.value);
    super.onInit();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(WelcomeView());
  }

  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  dynamic getDataUser() async {
    isLoading.value = true;
    await _firestore.collection('users').doc(_auth.currentUser!.uid).get().then(
      (DocumentSnapshot<dynamic> documentSnapshot) {
        userName.value = documentSnapshot.data()['username'] as String;
        phoneNumber.value = documentSnapshot.data()['no_hp'] as String;
        userEmail.value = documentSnapshot.data()['email'] as String;
        userImage.value = documentSnapshot.data()['user_image'] as String;
        log(documentSnapshot.toString());
        update();
      },
    );

    isLoading.value = false;
  }

  Future<void> getEducations() async {
    isLoading.value = true;

    try {
      await _firestore.collection('home').doc('educations').get().then((
        DocumentSnapshot<dynamic> documentSnapshot,
      ) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> educationsData =
            data['education_list'] as List<dynamic>;
        educationsList.value = educationsData
            .map(
              (dynamic e) => EducationModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        isLoading.value = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getHistory([String? userUsername]) async {
    final String targetUsername = userUsername ?? userName.value;

    if (targetUsername.isEmpty) {
      errorMessage.value = 'Username tidak ditemukan';
      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('history').doc(targetUsername).get();

      if (documentSnapshot.exists) {
        final Map<String, dynamic>? data = documentSnapshot.data();

        if (data != null && data.containsKey('quisoner_history')) {
          final List<dynamic> historyData =
              data['quisoner_history'] as List<dynamic>;

          if (historyData.isNotEmpty) {
            // Konversi ke model
            historyList.value = historyData
                .map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
                .toList();

            // Sort berdasarkan timestamp (terbaru di atas)
            // historyList.sort((a, b) {
            //   // Gunakan timestamp jika ada, fallback ke createdAt
            //   final aTime = a.timestamp ?? 0;
            //   final bTime = b.timestamp ?? 0;
            //   return bTime.compareTo(aTime);
            // });

            print('✅ Berhasil mengambil ${historyList.length} data history');
          } else {
            historyList.clear();
            print('📭 Data history kosong');
          }
        } else {
          historyList.clear();
          errorMessage.value = 'Data history tidak ditemukan';
        }
      } else {
        historyList.clear();
        errorMessage.value =
            'Dokumen tidak ditemukan untuk user: $targetUsername';
        print('❌ Dokumen tidak ditemukan');
      }
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data: ${e.toString()}';
      historyList.clear();
      print('❌ Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
      update(); // Trigger UI update
    }
  }

  // Future<dynamic> pickImage(ImageSource source) async {
  //   try {
  //     user = FirebaseAuth.instance.currentUser;

  //     final SettableMetadata metadata = SettableMetadata(
  //       contentType: 'image/jpeg',
  //     );
  //     final XFile? image = await ImagePicker().pickImage(source: source);
  //     final Reference ref = firebaseStorage
  //         .ref('users')
  //         .child('user_gallery')
  //         .child(user!.displayName!)
  //         .child('${user!.uid}.jpeg');

  //     if (image == null) {
  //       return Snack.show(
  //         SnackbarType.error,
  //         'Information',
  //         'Failed to pick image',
  //       );
  //     }
  //     final File imageTemp = File(image.path);
  //     await ref.putFile(imageTemp, metadata);
  //     final String url = await ref.getDownloadURL();
  //     Get.back();
  //     Snack.show(
  //       SnackbarType.success,
  //       'Image',
  //       'Image has been uploaded, Image will replaced after pressing Submit',
  //     );
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user!.uid)
  //         .update(<Object, Object?>{'user_image': url});
  //   } on PlatformException {
  //     Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
  //   }
  //   update();
  // }

  // Future<void> getHistory(String username) async {
  //   try {
  //     await _firestore.collection('history_scanner').doc(username).get().then((
  //       DocumentSnapshot<dynamic> documentSnapshot,
  //     ) {
  //       if (documentSnapshot.exists) {
  //         final Map<String, dynamic> data =
  //             documentSnapshot.data() as Map<String, dynamic>;

  //         // Akses field scan_history yang merupakan array
  //         final List<dynamic> historyData =
  //             data['scan_history'] as List<dynamic>;

  //         historyList.value = historyData
  //             .map(
  //               (dynamic e) => ScanHistory.fromJson(e as Map<String, dynamic>),
  //             )
  //             .toList();

  //         log(data.toString());
  //         update();
  //       } else {
  //         log('Dokumen tidak ditemukan untuk username: $username');
  //         historyList.value = []; // Set empty list jika dokumen tidak ada
  //       }
  //     });

  //     update();
  //   } catch (e) {
  //     log('Error fetching scan history: ${e.toString()}');
  //   }
  // }

  List<Widget> widgetViewList = <Widget>[
    const HomeView(),
    HistoryView(),
    const ProfileView(),
    // const ScanView(),
    // const HistoryView(),
    // const ProfileView(),
  ];

  void onTapNav(int index) {
    defaultIndex.value = index;

    for (final OnTapIdentifier element in onTapIdentifierList) {
      if (element.index == index) {
        onTapIdentifierList[index].isOnTapped = true;
      } else {
        onTapIdentifierList[element.index].isOnTapped = false;
      }
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get current user (nullable)
      final User? user = _auth.currentUser;

      // Check if user is logged in
      if (user == null) {
        throw Exception('No user logged in');
      }

      // Update password
      await user.updatePassword(newPassword);

      // Success
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Handle specific errors
      String message = _handleFirebaseError(e);
      errorMessage.value = message;

      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      print('Password change error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  String _handleFirebaseError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'requires-recent-login':
          return 'Please re-authenticate before changing password';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters';
        case 'user-not-found':
          return 'User not found';
        case 'wrong-password':
          return 'Current password is incorrect';
        default:
          return error.message ?? 'Failed to change password';
      }
    }
    return error.toString();
  }
}
