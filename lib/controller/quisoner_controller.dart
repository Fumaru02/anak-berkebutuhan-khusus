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
    double weight = getCFWeight(selectedIndex.value, totalItems);
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

  // Method untuk mendapatkan CF dari index
  double getCFWeight(int index, int totalItems) {
    // Konversi index ke CF (0-1)
    // Misal: 5 pilihan -> 0.0, 0.25, 0.5, 0.75, 1.0
    if (totalItems <= 1) return 0.0;

    double cf = index / (totalItems - 1);

    // Pastikan dalam rentang 0-1
    if (cf < 0) return 0.0;
    if (cf > 1) return 1.0;

    return cf;
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
    // Konversi ke CF (0-1)
    double cf = getCFWeight(index, totalItems);

    if (selectedIndex.value == index) {
      // Jika index sama, unselect
      selectedIndex.value = -1;
      print('Unselected index: $index');

      // Hapus semua isi list (karena tidak ada yang dipilih)
      selectedAnswerADHD.clear();
    } else {
      // Pilih index baru
      selectedIndex.value = index;

      // Ganti isi list dengan CF yang baru (bukan menambah)
      selectedAnswerADHD.clear(); // Kosongkan dulu
      selectedAnswerADHD.add(cf); // Tambahkan yang baru

      print('Selected index: $index, CF: ${cf.toStringAsFixed(2)}');
      update();
    }
  }

  double calculateScore() {
    // 1. Log semua data
    print('========== DATA BOBOT (CF) ==========');
    for (int i = 0; i < bobotQuisoner.length; i++) {
      print('Pertanyaan ${i + 1}: ${bobotQuisoner[i]}');
    }
    print('Total data: ${bobotQuisoner.length}');
    print('===========================================');

    // 2. Konversi bobot ke Certainty Factor (0-1)
    List<double> cfValues = [];
    for (int i = 0; i < bobotQuisoner.length; i++) {
      double bobot = bobotQuisoner[i];

      // Bobot sudah dalam bentuk CF (0-1)
      // Normalisasi jika perlu
      double cf = _normalizeCF(bobot);
      cfValues.add(cf);

      print(
        '📊 Pertanyaan ${i + 1}: Bobot=${bobot.toStringAsFixed(2)} -> CF=${cf.toStringAsFixed(2)}',
      );
    }
    print('===========================================');

    // 3. Hitung CF menggunakan metode kombinasi
    double cfResult = _combineCF(cfValues);
    print('✅ CF Hasil Kombinasi: ${(cfResult * 100).toStringAsFixed(2)}%');
    print('===========================================');

    // 4. Konversi ke persentase (0-100)
    double persentase = cfResult * 100;

    // 5. Pembulatan ke 2 desimal
    double finalScore = double.parse(persentase.toStringAsFixed(2));
    print('✅ Skor Akhir: $finalScore%');
    print('===========================================');

    return finalScore;
  }

  // Method untuk normalisasi CF (jika bobot belum dalam rentang 0-1)
  double _normalizeCF(double bobot) {
    // Jika bobot sudah dalam rentang 0-1
    if (bobot >= 0 && bobot <= 1) {
      return bobot;
    }

    // Jika bobot dalam rentang 0-100 (persentase)
    if (bobot > 1 && bobot <= 100) {
      return bobot / 100;
    }

    // Jika bobot dalam rentang 1-5 (Likert)
    if (bobot >= 1 && bobot <= 5) {
      return (bobot - 1) / 4;
    }

    // Default
    print('⚠️ Peringatan: Nilai bobot ${bobot} tidak dikenal, menggunakan 0.0');
    return 0.0;
  }

  // Method untuk mengkombinasikan CF
  double _combineCF(List<double> cfValues) {
    if (cfValues.isEmpty) return 0.0;

    // Filter CF yang valid (> 0)
    List<double> validCF = cfValues.where((cf) => cf > 0.0).toList();

    if (validCF.isEmpty) return 0.0;

    // Metode kombinasi CF: CF1 + CF2 * (1 - CF1)
    double result = validCF.first;
    for (int i = 1; i < validCF.length; i++) {
      result = result + validCF[i] * (1 - result);
    }

    return result;
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
