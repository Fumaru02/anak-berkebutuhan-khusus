import 'dart:developer';

import 'package:anak_berkebutuhan_khusus/models/quisoner_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuisonerController extends GetxController {
  RxList<QuisonerModel> adhdList = RxList<QuisonerModel>(<QuisonerModel>[]);
  RxList<QuisonerModel> asdList = RxList<QuisonerModel>(<QuisonerModel>[]);
  RxList<QuisonerModel> disleksiaList = RxList<QuisonerModel>(
    <QuisonerModel>[],
  );
  RxList<QuisonerModel> tunagrahitaList = RxList<QuisonerModel>(
    <QuisonerModel>[],
  );
  RxList<QuisonerModel> quisonerList = RxList<QuisonerModel>(<QuisonerModel>[]);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxInt selectedIndex = RxInt(-1);
  final RxBool isSelected = RxBool(false);
  final RxBool isLoading = RxBool(false);
  final List selectedAnswerADHD = <double>[];
  final RxList bobotQuisoner = RxList<double>(<double>[]);
  final List selectedIndices = <int>[].obs;
  final RxInt currentPage = RxInt(0);
  final PageController pageController = PageController();
  RxInt currentIndex = RxInt(0);
  RxInt hasChangedTitle = RxInt(0);
  RxDouble finalScoreADHD = RxDouble(0);
  RxDouble finalScoreASD = RxDouble(0);
  RxDouble finalScoreDISLEKSIA = RxDouble(0);
  RxDouble finalScoreTUNAGRAHITA = RxDouble(0);
  RxString username = RxString('');

  List<QuisonerModel> quisonersList() {
    quisonerList.value = adhdList + asdList + disleksiaList + tunagrahitaList;
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
        final List<dynamic> disleksiaData =
            data['DISLEKSIA'] as List<dynamic>? ?? [];
        final List<dynamic> tunagrahitaData =
            data['TUNAGRAHITA'] as List<dynamic>? ?? [];
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
        disleksiaList.value = disleksiaData
            .map(
              (dynamic e) => QuisonerModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        tunagrahitaList.value = tunagrahitaData
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
    bobotQuisoner.add(weight);
    hasChangedTitle.value = bobotQuisoner.length;
    log('Jumlah data BOBOT ADHD: ${bobotQuisoner.length}');
    log('Jumlah has changed: ${hasChangedTitle.value}');

    if (selectedIndex.value == -1) {
      Get.snackbar(
        'Peringatan',
        'Silakan pilih minimal satu opsi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (currentPage.value <= adhdList.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
    }
    selectedIndex.value = -1;
  }

  double getWeight(int index, int totalItems) {
    if (totalItems <= 1) return 1.0;
    return 1.0 + (index * (4.0 / (totalItems - 1)));
  }

  String formatIndonesianDateTime(DateTime dateTime) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final hour = dateTime.hour;
    final minute = dateTime.minute;

    // Format waktu menjadi 12.00 WIB
    final timeFormatted =
        '${hour.toString().padLeft(2, '0')}.${minute.toString().padLeft(2, '0')} WIB';

    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year} | $timeFormatted';
  }

  String getFormattedTimestampIndonesia() {
    final now = DateTime.now();
    return formatIndonesianDateTime(now);
  }

  Future<void> uploadScoreHistory() async {
    isLoading.value = true;
    try {
      final timestamp = DateTime.now();
      final formattedTime = formatIndonesianDateTime(timestamp);

      await FirebaseFirestore.instance
          .collection('history')
          .doc(username.value)
          .update({
            'quisoner_history': FieldValue.arrayUnion([
              {
                'ADHD_score': finalScoreADHD.toDouble(),
                'ASD_score': finalScoreASD.toDouble(),
                'DISLEKSIA_score': finalScoreDISLEKSIA.toDouble(),
                'TUNAGRAHITA_score': finalScoreTUNAGRAHITA.toDouble(),
                'creation_time': formattedTime, // Format Indonesia
                'timestamp': timestamp.millisecondsSinceEpoch, // Untuk sorting
                'timestamp_iso': timestamp.toIso8601String(), // Backup format
              },
            ]),
            'username': username.value,
            'last_updated': FieldValue.serverTimestamp(),
          });
      isLoading.value = false;
    } catch (e) {
      if (e is FirebaseException && e.code == 'not-found') {
        final timestamp = DateTime.now();
        final formattedTime = formatIndonesianDateTime(timestamp);

        await FirebaseFirestore.instance
            .collection('history')
            .doc(username.value)
            .set({
              'quisoner_history': FieldValue.arrayUnion([
                {
                  'ADHD_score': finalScoreADHD.toDouble(),
                  'ASD_score': finalScoreASD.toDouble(),
                  'DISLEKSIA_score': finalScoreDISLEKSIA.toDouble(),
                  'TUNAGRAHITA_score': finalScoreTUNAGRAHITA.toDouble(),
                  'creation_time': formattedTime, // Format Indonesia
                  'timestamp':
                      timestamp.millisecondsSinceEpoch, // Untuk sorting
                  'timestamp_iso': timestamp.toIso8601String(), // Backup format
                },
              ]),
              'username': username.value,
              'last_updated': FieldValue.serverTimestamp(),
            });
        isLoading.value = false;
      } else {
        isLoading.value = false;
        rethrow;
      }
    }
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

  double calculateScore() {
    // 1. Log semua data
    print('========== DATA BOBOT ADHD ==========');
    for (int i = 0; i < bobotQuisoner.length; i++) {
      print('Pertanyaan ${i + 1}: ${bobotQuisoner[i]}');
    }
    print('Total data: ${bobotQuisoner.length}');
    print('=====================================');

    // 2. Hitung Total Skor
    double totalSkor = bobotQuisoner.fold(
      0,
      (double sum, weight) => sum + weight,
    );
    print('✅ Total Skor: $totalSkor');

    // 3. Hitung Skor Maksimal
    int jumlahPernyataan = bobotQuisoner.length;
    int skorMaksimal = jumlahPernyataan * 5; // Maksimal 5 per pertanyaan
    print('✅ Jumlah Pernyataan: $jumlahPernyataan');
    print('✅ Skor Maksimal: $skorMaksimal');

    // 4. Hitung Persentase
    double persentase = (totalSkor / skorMaksimal) * 100;
    print('✅ Persentase: ${persentase.toStringAsFixed(2)}%');

    print('=====================================');

    // 5. Simpan hasil ke variabel (opsional)
    // this.totalSkor.value = totalSkor;
    // this.skorMaksimal.value = skorMaksimal;
    // this.persentase.value = persentase;

    return double.parse(persentase.toStringAsFixed(2));
  }

  void collectiongScore() async {
    if (currentPage.value == 12) {
      finalScoreADHD.value = calculateScore();
      log('Clear bobot quisoner');
      bobotQuisoner.clear();
    }
    if (currentPage.value == 25) {
      finalScoreASD.value = calculateScore();
      log('Clear bobot quisoner');
      bobotQuisoner.clear();
    }
    if (currentPage.value == 35) {
      finalScoreDISLEKSIA.value = calculateScore();
      log('Clear bobot quisoner');
      bobotQuisoner.clear();
    }
    if (currentPage.value == 45) {
      finalScoreTUNAGRAHITA.value = calculateScore();
      await uploadScoreHistory();
      log('Clear bobot quisoner');
      bobotQuisoner.clear();
    }
  }
}
