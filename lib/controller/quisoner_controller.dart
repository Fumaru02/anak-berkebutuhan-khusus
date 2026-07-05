import 'dart:developer';

import 'package:anak_berkebutuhan_khusus/models/quisoner/quisoner_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuisonerController extends GetxController {
  RxList<QuisonerModel> adhdList = RxList<QuisonerModel>(<QuisonerModel>[]);
  RxList<QuisonerModel> asdList = RxList<QuisonerModel>(<QuisonerModel>[]);
  RxList<QuisonerModel> quisonerList = RxList<QuisonerModel>(<QuisonerModel>[]);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxInt selectedIndex = RxInt(-1);
  final RxBool isSelected = RxBool(false);
  final List selectedAnswerADHD = <double>[];
  final List bobotADHD = <double>[];
  final List selectedIndices = <int>[].obs;
  final RxInt currentPage = RxInt(0);
  final PageController pageController = PageController();

  List<QuisonerModel> quisonersList() {
    quisonerList.value = [...adhdList, ...asdList];
    return quisonerList;
  }

  Future<void> getQuisoners() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore
          .collection('data')
          .doc('quisoners')
          .get();

      if (documentSnapshot.exists) {
        final Map<String, dynamic> data = documentSnapshot.data()!;

        // PERBAIKAN: Gunakan 'ADHD' bukan 'test'
        final List<dynamic> adhdData = data['ADHD'] as List<dynamic>? ?? [];
        final List<dynamic> asdData = data['ASD'] as List<dynamic>? ?? [];
        asdList.value = asdData
            .map(
              (dynamic e) => QuisonerModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();

        adhdList.value = adhdData
            .map(
              (dynamic e) => QuisonerModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        quisonersList();
        log('Jumlah data ADHD + ASD: ${quisonerList.value.length}');
        log('Jumlah data ADHD: ${adhdList.value.length}');
        log('Jumlah data ASD: ${asdList.value.length}');
      } else {
        log('Dokumen tidak ditemukan');
      }
    } catch (e) {
      log('Error getQuisoners: $e');
    }
  }

  void saveAllAnswers(int totalItems) {
    double weight = getWeight(selectedIndex.value, totalItems);
    bobotADHD.add(weight);
    log('Jumlah data BOBOT ADHD: ${bobotADHD.length}');

    if (selectedIndex.value == -1) {
      Get.snackbar(
        'Peringatan',
        'Silakan pilih minimal satu opsi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (currentPage.value < adhdList.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  double getWeight(int index, int totalItems) {
    if (totalItems <= 1) return 1.0;
    return 1.0 + (index * (4.0 / (totalItems - 1)));
  }

  void selectItem(int index, int totalItems) {
    double weight = getWeight(index, totalItems);

    if (selectedIndex.value == index) {
      // Jika index sama, unselect
      selectedIndex.value = -1;
      print('Unselected index: $index');

      // Hapus semua isi list (karena tidak ada yang dipilih)
      selectedAnswerADHD.clear();
    } else {
      // Pilih index baru
      selectedIndex.value = index;

      // Ganti isi list dengan weight yang baru (bukan menambah)
      selectedAnswerADHD.clear(); // Kosongkan dulu
      selectedAnswerADHD.add(weight); // Tambahkan yang baru

      print('Selected index: $index, Bobot: $weight');
    }

    log('Jumlah jawaban terpilih: ${selectedAnswerADHD.length}');
    update();
  }
}
