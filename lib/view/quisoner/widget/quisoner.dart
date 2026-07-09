import 'dart:developer';

import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/login_view_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/quisoner_controller.dart';
import 'package:anak_berkebutuhan_khusus/models/quisoner/quisoner_model.dart';
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
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 5),

          RippleButton(
            onTap: () => Get.back(),
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
            size: SizeConfig.safeBlockHorizontal * 10,
            color: AppColors.blackColor,
          ),
          BlueStrip(),
          SpaceSizer(vertical: 1),
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
                    ? IndicationPart(
                        animatedController: animatedController,
                        quisonerController: quisonerController,
                      )
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
  const IndicationPart({
    super.key,
    required this.animatedController,
    required this.quisonerController,
  });

  final AnimatedController animatedController;
  final QuisonerController quisonerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RubikTextView(
          value: 'Hasil akhir semua gangguan',
          fontWeight: FontWeight.w500,
          size: SizeConfig.safeBlockHorizontal * 5,
          color: AppColors.blackColor,
        ),
        SpaceSizer(vertical: 1),
        Center(
          child: Column(
            children: [
              PersentageContainer(
                title: 'ADHD',
                persentase: quisonerController.finalScoreADHD.value,
                colorContainer: AppColors.blackColor,
              ),
              SpaceSizer(vertical: 1),
              PersentageContainer(
                title: 'ASD',
                persentase: quisonerController.finalScoreASD.value,

                colorContainer: AppColors.blackColor,
              ),
              SpaceSizer(vertical: 1),

              PersentageContainer(
                title: 'DISLEKSIA',
                persentase: quisonerController.finalScoreDISLEKSIA.value,
                colorContainer: AppColors.blackColor,
              ),
              SpaceSizer(vertical: 1),

              PersentageContainer(
                title: 'TUNAGRAHITA',
                persentase: quisonerController.finalScoreTUNAGRAHITA.value,
                colorContainer: AppColors.blackColor,
              ),
            ],
          ),
        ),
        SpaceSizer(vertical: 1),
        RubikTextView(
          value: 'Urutan paling dominan',
          fontWeight: FontWeight.w500,
          size: SizeConfig.safeBlockHorizontal * 5,
          color: AppColors.blackColor,
        ),
        SpaceSizer(vertical: 1),

        Obx(() {
          List<Map<String, dynamic>> data = [
            {'title': 'ADHD', 'value': quisonerController.finalScoreADHD.value},
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

          // Debug: print sebelum sorting
          print('Sebelum sorting: $data');

          // Sorting descending
          data.sort((a, b) => b['value'].compareTo(a['value']));

          // Debug: print setelah sorting
          print('Setelah sorting: $data');

          return Column(
            children: data.map((item) {
              return Column(
                children: [
                  PersentageContainer(
                    title: item['title'],
                    persentase: item['value'],
                    colorContainer: AppColors.blackColor,
                  ),
                  SpaceSizer(vertical: 1),
                ],
              );
            }).toList(),
          );
        }),
        SpaceSizer(vertical: 3),

        Obx(
          () => CustomFlatButton(
            loading: quisonerController.isLoading.value,
            width: 96,
            text: 'Selesai',
            onTap: () async {
              await quisonerController.uploadScoreHistory();
            },
          ),
        ),
      ],
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
      builder: (QuisonerController quisonerController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 2),

          RubikTextView(
            value: quisonerModel.gejala,
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 5,
            color: AppColors.blackColor,
          ),
          SpaceSizer(vertical: 3),
          Center(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: approvement.length,
                  itemBuilder: (context, index) {
                    quisonerController.isSelected.value =
                        quisonerController.selectedIndex.value == index;
                    // Kirim approvement.length sebagai totalItems
                    return RippleButton(
                      onTap: () {
                        quisonerController.selectItem(
                          index,
                          approvement.length,
                        );
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: quisonerController.isSelected.value
                                    ? AppColors.blueColor
                                    : AppColors.greyCard,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.horizontal(2)),
                                ),
                                border: Border.all(
                                  color: quisonerController.isSelected.value
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                ),
                              ),
                              width: SizeConfig.horizontal(80),
                              height: SizeConfig.horizontal(12),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  SizeConfig.horizontal(2),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RubikTextView(
                                      value: approvement[index],
                                      fontWeight: FontWeight.w500,
                                      size: SizeConfig.safeBlockHorizontal * 4,
                                      color: quisonerController.isSelected.value
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    ),
                                    RubikTextView(
                                      value: approvementS[index],
                                      fontWeight: FontWeight.w500,
                                      size: SizeConfig.safeBlockHorizontal * 2,
                                      color: quisonerController.isSelected.value
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SpaceSizer(vertical: 1),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SpaceSizer(vertical: 2),

                quisonerController.selectedIndex.value == -1
                    ? SizedBox()
                    : CustomFlatButton(
                        text: quisonerController.currentPage.value <= 44
                            ? 'Selanjutnya'
                            : 'Selesai',
                        onTap: () {
                          quisonerController.saveAllAnswers(approvement.length);
                          log(
                            quisonerController.selectedAnswerADHD.length
                                .toString(),
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
                      ),
                SpaceSizer(vertical: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
