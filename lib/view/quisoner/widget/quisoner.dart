import 'dart:developer';

import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/frame_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/login_view_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/quisoner_controller.dart';
import 'package:anak_berkebutuhan_khusus/models/quisoner_model.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quisoner extends StatelessWidget {
  const Quisoner({
    super.key,
    required this.animatedController,
    required this.quisonerController,
  });

  final AnimatedController animatedController;
  final QuisonerController quisonerController;

  @override
  Widget build(BuildContext context) {
    final FrameController frameController = Get.put(FrameController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 5),

          RippleButton(
            onTap: () async {
              await frameController.getHistory(frameController.userName.value);
              Get.back();
              quisonerController.finalScoreADHD.value = 0;
              quisonerController.finalScoreASD.value = 0;
              quisonerController.finalScoreDISLEKSIA.value = 0;
              quisonerController.finalScoreTUNAGRAHITA.value = 0;
              quisonerController.currentPage.value = 0;
            },
            child: Image.asset(
              AssetList.kembaliIcon,
              width: SizeConfig.horizontal(30),
              height: SizeConfig.horizontal(10),
            ),
          ),
          RubikTextView(
            value: quisonerController.currentPage.value == 45
                ? 'Indikasi'
                : 'Quisoner',
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 6,
            color: AppColors.blackColor,
          ),

          BlueStrip(),
          SpaceSizer(vertical: 0.5),

          quisonerController.currentPage.value == 45
              ? SizedBox()
              : Container(
                  color: AppColors.blueColor,
                  width: SizeConfig.horizontal(96),
                  child: Center(
                    child: Obx(
                      () => RubikTextView(
                        value: quisonerController.currentPage.value < 12
                            ? 'ADHD'
                            : quisonerController.currentPage.value < 25
                            ? 'ASD'
                            : quisonerController.currentPage.value < 35
                            ? 'DISLEKSIA'
                            : quisonerController.currentPage.value < 45
                            ? 'TUNAGRAHITA'
                            : '',
                        fontWeight: FontWeight.w500,
                        size: SizeConfig.safeBlockHorizontal * 5,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            width: SizeConfig.horizontal(100),
            height: SizeConfig.screenHeight,
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: quisonerController.pageController,
              itemCount: quisonerController.quisonerList.length,
              onPageChanged: (index) {
                quisonerController.currentPage.value = index;
                log('pagechanged ${index}');
              },
              itemBuilder: (context, index) => Obx(
                () => quisonerController.currentPage.value == 45
                    ? IndicationPart(quisonerController: quisonerController)
                    : QuisonerPart(
                        quisonerModel: quisonerController.quisonerList[index],
                        animatedController: animatedController,
                      ),
              ),

              // IndicationPart(animatedController: animatedController),
              // RatePart(animatedController: animatedController),
            ),
          ),
        ],
      ),
    );
  }
}

class RatePart extends StatelessWidget {
  const RatePart({super.key, required this.animatedController});

  final AnimatedController animatedController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSizer(vertical: 12),

        SpaceSizer(vertical: 1),
        RubikTextView(
          value: 'Nilai Kami!',
          fontWeight: FontWeight.w500,
          size: SizeConfig.safeBlockHorizontal * 10,
          color: AppColors.blackColor,
        ),
        BlueStrip(),

        SpaceSizer(vertical: 1),
        Icon(
          Icons.star,
          size: SizeConfig.safeBlockHorizontal * 12,
          color: Colors.yellow,
        ),
        SpaceSizer(vertical: 5),
        Center(
          child: Column(
            children: [
              SpaceSizer(vertical: 22),

              CustomFlatButton(
                text: 'Finish',
                onTap: () => animatedController.toggleAnimateQuisoner(),
              ),
              SpaceSizer(vertical: 1),
            ],
          ),
        ),
      ],
    );
  }
}

class IndicationPart extends StatelessWidget {
  const IndicationPart({super.key, required this.quisonerController});

  final QuisonerController quisonerController;

  // Helper method untuk mendapatkan warna berdasarkan nilai
  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.red.shade700;
    if (score >= 60) return Colors.orange.shade700;
    if (score >= 40) return Colors.yellow.shade700;
    if (score >= 20) return Colors.green.shade700;
    return Colors.blue.shade700;
  }

  // Helper method untuk mendapatkan label berdasarkan nilai
  String _getScoreLabel(double score) {
    if (score >= 80) return 'Sangat Tinggi';
    if (score >= 60) return 'Tinggi';
    if (score >= 40) return 'Sedang';
    if (score >= 20) return 'Rendah';
    return 'Sangat Rendah';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 2,
        vertical: SizeConfig.safeBlockVertical * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan icon
          Row(
            children: [
              Icon(
                Icons.assessment_outlined,
                color: AppColors.orangeActive,
                size: SizeConfig.safeBlockHorizontal * 6,
              ),
              SpaceSizer(horizontal: 2),
              RubikTextView(
                value: 'Hasil Akhir Semua Gangguan',
                fontWeight: FontWeight.w600,
                size: SizeConfig.safeBlockHorizontal * 4,
                color: AppColors.blackColor,
              ),
            ],
          ),

          // Card untuk semua skor dengan Obx
          Obx(() {
            // Ambil semua data dari controller
            List<Map<String, dynamic>> allData = [
              {
                'title': 'ADHD',
                'value': quisonerController.finalScoreADHD.value,
                'key': 'ADHD',
              },
              {
                'title': 'ASD',
                'value': quisonerController.finalScoreASD.value,
                'key': 'ASD',
              },
              {
                'title': 'DISLEKSIA',
                'value': quisonerController.finalScoreDISLEKSIA.value,
                'key': 'DISLEKSIA',
              },
              {
                'title': 'TUNAGRAHITA',
                'value': quisonerController.finalScoreTUNAGRAHITA.value,
                'key': 'TUNAGRAHITA',
              },
            ];

            // Sort data untuk ranking
            List<Map<String, dynamic>> sortedData = List.from(allData);
            sortedData.sort((a, b) => b['value'].compareTo(a['value']));

            return Column(
              children: [
                // Grid untuk menampilkan semua skor
                Container(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.safeBlockHorizontal * 2,
                      mainAxisSpacing: SizeConfig.safeBlockVertical * 1.5,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      final item = allData[index];
                      final color = _getScoreColor(item['value']);
                      final isHighest =
                          sortedData.isNotEmpty &&
                          sortedData.first['key'] == item['key'];

                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isHighest ? color : Colors.grey.shade300,
                            width: isHighest ? 2 : 1,
                          ),
                          boxShadow: isHighest
                              ? [
                                  BoxShadow(
                                    color: color.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Title
                            RubikTextView(
                              value: item['title'],
                              fontWeight: FontWeight.w600,
                              size: SizeConfig.safeBlockHorizontal * 3.5,
                              color: Colors.grey.shade700,
                            ),
                            SpaceSizer(vertical: 0.5),
                            // Score dengan animasi progress
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RubikTextView(
                                  value: item['value'].toStringAsFixed(0),
                                  fontWeight: FontWeight.bold,
                                  size: SizeConfig.safeBlockHorizontal * 5,
                                  color: color,
                                ),
                                RubikTextView(
                                  value: '%',
                                  fontWeight: FontWeight.w500,
                                  size: SizeConfig.safeBlockHorizontal * 2.5,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                            // Progress bar
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              width: double.infinity,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: item['value'] / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [color, color.withOpacity(0.7)],
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            if (isHighest)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: RubikTextView(
                                  value: '★ Paling Dominan',
                                  fontWeight: FontWeight.w500,
                                  size: SizeConfig.safeBlockHorizontal * 2.5,
                                  color: color,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),

          // Section: Urutan Paling Dominan dengan Obx
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: AppColors.orangeActive,
                size: SizeConfig.safeBlockHorizontal * 5,
              ),
              SpaceSizer(horizontal: 2),
              RubikTextView(
                value: 'Urutan Paling Dominan',
                fontWeight: FontWeight.w600,
                size: SizeConfig.safeBlockHorizontal * 5,
                color: AppColors.blackColor,
              ),
            ],
          ),

          Obx(() {
            // Ambil data untuk ranking
            List<Map<String, dynamic>> data = [
              {
                'title': 'ADHD',
                'value': quisonerController.finalScoreADHD.value,
              },
              {'title': 'ASD', 'value': quisonerController.finalScoreASD.value},
              {
                'title': 'DISLEKSIA',
                'value': quisonerController.finalScoreDISLEKSIA.value,
              },
              {
                'title': 'TUNAGRAHITA',
                'value': quisonerController.finalScoreTUNAGRAHITA.value,
              },
            ];

            // Sorting descending
            data.sort((a, b) => b['value'].compareTo(a['value']));

            // List ranking dengan nomor urut
            return Container(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: data.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  Color scoreColor = _getScoreColor(item['value']);

                  return Container(
                    margin: EdgeInsets.only(
                      bottom: index < data.length - 1 ? 1 : 0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontal(1),
                      vertical: SizeConfig.horizontal(1),
                    ),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? scoreColor.withOpacity(0.05)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: index == 0
                          ? Border.all(color: scoreColor.withOpacity(0.3))
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Ranking number
                        Container(
                          width: SizeConfig.horizontal(5),
                          height: SizeConfig.horizontal(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                index == 0 ? scoreColor : Colors.grey.shade400,
                                index == 0
                                    ? scoreColor.withOpacity(0.7)
                                    : Colors.grey.shade300,
                              ],
                            ),
                          ),
                          child: Center(
                            child: RubikTextView(
                              value: '${index + 1}',
                              fontWeight: FontWeight.bold,
                              size: SizeConfig.safeBlockHorizontal * 3.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SpaceSizer(horizontal: 3),
                        // Title
                        Expanded(
                          child: RubikTextView(
                            value: item['title'],
                            fontWeight: FontWeight.w500,
                            size: SizeConfig.safeBlockHorizontal * 4,
                            color: AppColors.blackColor,
                          ),
                        ),
                        // Score
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: scoreColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              RubikTextView(
                                value: item['value'].toStringAsFixed(0),
                                fontWeight: FontWeight.w600,
                                size: SizeConfig.safeBlockHorizontal * 3.5,
                                color: scoreColor,
                              ),
                              RubikTextView(
                                value: '%',
                                fontWeight: FontWeight.w500,
                                size: SizeConfig.safeBlockHorizontal * 2.5,
                                color: scoreColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }),

          // Info tambahan

          // Tombol Selesai dengan Obx
        ],
      ),
    );
  }
}

class PersentageContainer extends StatelessWidget {
  const PersentageContainer({
    super.key,
    required this.title,
    required this.colorContainer,
    required this.persentase,
  });

  final String title;
  final Color colorContainer;
  final double persentase;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: SizeConfig.horizontal(95),
          height: SizeConfig.vertical(4),
          color: colorContainer,
        ),
        Container(
          width: SizeConfig.horizontal(95 * (persentase / 100)),
          height: SizeConfig.vertical(4),
          color: AppColors.maroon,
        ),
        Center(
          child: Column(
            children: [
              SpaceSizer(vertical: 1),
              RubikTextView(
                value: '$title $persentase%',
                size: SizeConfig.safeBlockHorizontal * 3.5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuisonerPart extends StatelessWidget {
  const QuisonerPart({
    super.key,
    required this.animatedController,
    required this.quisonerModel,
  });

  final AnimatedController animatedController;
  final QuisonerModel quisonerModel;

  @override
  Widget build(BuildContext context) {
    List approvement = [
      'Sangat Tidak Setuju',
      'Tidak Setuju',
      'Netral',
      'Setuju',
      'Sangat Setuju',
    ];
    List approvementS = ['STS', 'TS', 'N', 'S', 'SS'];

    return GetBuilder(
      init: QuisonerController(),
      builder: (QuisonerController quisonerController) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceSizer(vertical: 0.5),

            // Question Number Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 2.5,
                vertical: SizeConfig.safeBlockVertical * 0.5,
              ),
              decoration: BoxDecoration(
                color: AppColors.blueColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: RubikTextView(
                value: 'Pertanyaan ${quisonerController.currentPage.value + 1}',
                fontWeight: FontWeight.w600,
                size: SizeConfig.safeBlockHorizontal * 3,
                color: AppColors.blueColor,
              ),
            ),

            // Question Card
            Container(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.5),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: RubikTextView(
                value: quisonerModel.gejala,
                fontWeight: FontWeight.w500,
                size: SizeConfig.safeBlockHorizontal * 4,
                color: AppColors.blackColor,
              ),
            ),
            SpaceSizer(vertical: 0.5),
            // Answer Options
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: approvement.length,
              itemBuilder: (context, index) {
                quisonerController.isSelected.value =
                    quisonerController.selectedIndex.value == index;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.safeBlockVertical * 1.2,
                  ),
                  child: RippleButton(
                    onTap: () {
                      quisonerController.selectItem(index, approvement.length);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 4,
                        vertical: SizeConfig.safeBlockVertical * 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: quisonerController.isSelected.value
                            ? AppColors.blueColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: quisonerController.isSelected.value
                              ? AppColors.blueColor
                              : Colors.grey.shade300,
                          width: quisonerController.isSelected.value ? 2 : 1,
                        ),
                        boxShadow: quisonerController.isSelected.value
                            ? [
                                BoxShadow(
                                  color: AppColors.blueColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Row(
                        children: [
                          // Radio Indicator
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: quisonerController.isSelected.value
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              color: quisonerController.isSelected.value
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: quisonerController.isSelected.value
                                ? Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.blueColor,
                                      ),
                                    ),
                                  )
                                : null,
                          ),

                          SpaceSizer(horizontal: 2.5),

                          // Text Label
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RubikTextView(
                                  value: approvement[index],
                                  fontWeight: FontWeight.w500,
                                  size: SizeConfig.safeBlockHorizontal * 3.8,
                                  color: quisonerController.isSelected.value
                                      ? Colors.white
                                      : AppColors.blackColor,
                                ),
                                RubikTextView(
                                  value: approvementS[index],
                                  fontWeight: FontWeight.w400,
                                  size: SizeConfig.safeBlockHorizontal * 2.5,
                                  color: quisonerController.isSelected.value
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),

                          // Check Icon when selected
                          if (quisonerController.isSelected.value)
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.white,
                              size: SizeConfig.safeBlockHorizontal * 4.5,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            SpaceSizer(vertical: 1),

            // Next Button
            quisonerController.selectedIndex.value == -1
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.safeBlockVertical * 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: RubikTextView(
                        value: quisonerController.currentPage.value <= 44
                            ? 'Pilih jawaban terlebih dahulu'
                            : 'Selesai',
                        fontWeight: FontWeight.w500,
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )
                : CustomFlatButton(
                    text: quisonerController.currentPage.value <= 44
                        ? 'Selanjutnya'
                        : 'Selesai',
                    onTap: () {
                      quisonerController.saveAllAnswers(approvement.length);
                      log(
                        quisonerController.selectedAnswerADHD.length.toString(),
                      );
                      switch (quisonerController.currentPage.value) {
                        case 12:
                        case 25:
                        case 35:
                        case 45:
                          quisonerController.collectiongScore();
                          break;
                        case 44:
                          // Kosong, tidak melakukan apa-apa
                          break;
                      }
                    },
                    width: 100,
                    height: 5,
                    radius: 2,
                    textSize: 3.8,
                  ),

            SpaceSizer(vertical: 2),
          ],
        ),
      ),
    );
  }
}
