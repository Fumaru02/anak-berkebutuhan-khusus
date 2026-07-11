import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/frame_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/quisoner_controller.dart';
import 'package:anak_berkebutuhan_khusus/models/history_model.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/frame/frame_scaffold.dart';
import 'package:anak_berkebutuhan_khusus/view/quisoner/widget/quisoner.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_text_field.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: FrameScaffold(
        heightBar: 0,
        elevation: 0,
        color: Colors.black,
        statusBarColor: Colors.black,
        colorScaffold: Colors.black,
        statusBarBrightness: Brightness.light,
        view: Stack(
          children: [
            SizedBox(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(100),
              child: Image.asset(AssetList.splashScreen, fit: BoxFit.cover),
            ),
            Container(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(100),
              color: AppColors.blueColor.withValues(alpha: 0.9),
            ),
            Container(
              height: SizeConfig.screenHeight,
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  History(),
                  // IndicationPartHistory(animatedController: animatedController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndicationPartHistory extends StatelessWidget {
  const IndicationPartHistory({
    super.key,
    required this.frameController,
    required this.historyModel,
  });

  final FrameController frameController;
  final HistoryModel historyModel;

  List<Map<String, dynamic>> getSortedData(HistoryModel historyModel) {
    List<Map<String, dynamic>> data = [
      {'title': 'ADHD', 'value': historyModel.adhdScore},
      {'title': 'ASD', 'value': historyModel.asdScore},
      {'title': 'DISLEKSIA', 'value': historyModel.disleksiaScore},
      {'title': 'TUNAGRAHITA', 'value': historyModel.tunagrahitaScore},
    ];

    data.sort((a, b) => b['value'].compareTo(a['value']));
    return data;
  }

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
    List<Map<String, dynamic>> sortedData = getSortedData(historyModel);
    double maxScore = sortedData.isNotEmpty ? sortedData.first['value'] : 0;

    return FrameScaffold(
      color: AppColors.blackColor,
      colorScaffold: AppColors.blueColor,
      view: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 4,
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
                  color: AppColors.blackColor,
                  size: SizeConfig.safeBlockHorizontal * 6,
                ),
                SpaceSizer(horizontal: 2),
                RubikTextView(
                  value: 'Hasil Akhir Semua Gangguan',
                  fontWeight: FontWeight.w600,
                  size: SizeConfig.safeBlockHorizontal * 5.5,
                  color: AppColors.blackColor,
                ),
              ],
            ),
            SpaceSizer(vertical: 2),

            // Card untuk semua skor
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
              child: Column(
                children: [
                  // Grid untuk menampilkan semua skor
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.safeBlockHorizontal * 2,
                      mainAxisSpacing: SizeConfig.safeBlockVertical * 1.5,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: sortedData.length,
                    itemBuilder: (context, index) {
                      final item = sortedData[index];
                      final color = _getScoreColor(item['value']);
                      final isHighest = index == 0;

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
                ],
              ),
            ),

            SpaceSizer(vertical: 2),

            // Section: Urutan Paling Dominan
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: AppColors.blackColor,
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
            SpaceSizer(vertical: 1.5),

            // List ranking dengan nomor urut
            Container(
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
                children: sortedData.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  Color scoreColor = _getScoreColor(item['value']);

                  return Container(
                    margin: EdgeInsets.only(
                      bottom: index < sortedData.length - 1 ? 8 : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          width: 28,
                          height: 28,
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
            ),

            SpaceSizer(vertical: 2),

            // Info tambahan
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: SizeConfig.safeBlockHorizontal * 4,
                  ),
                  SpaceSizer(horizontal: 2),
                  Expanded(
                    child: RubikTextView(
                      value:
                          'Skor tertinggi menunjukkan gangguan yang paling dominan',
                      fontWeight: FontWeight.w400,
                      size: SizeConfig.safeBlockHorizontal * 3.2,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Get.find() untuk mengambil instance yang sudah ada
    final FrameController frameController = Get.find<FrameController>();
    final QuisonerController quisonerController = Get.put(QuisonerController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSizer(vertical: 3),
        RubikTextView(
          value: 'History',
          fontWeight: FontWeight.w500,
          size: SizeConfig.safeBlockHorizontal * 10,
          color: AppColors.blackColor,
        ),
        SpaceSizer(vertical: 2),
        BlueStrip(),
        SpaceSizer(vertical: 2),

        // Gunakan Obx untuk reactive update
        Obx(() {
          // Cek loading state
          if (frameController.isLoading.value) {
            return Container(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(50),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.blueColor),
              ),
            );
          }

          // Cek error
          if (frameController.errorMessage.value.isNotEmpty) {
            return Container(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50, color: Colors.red),
                    SpaceSizer(vertical: 2),
                    RubikTextView(
                      value: frameController.errorMessage.value,
                      size: 14,
                      color: Colors.red,
                      // textAlign: TextAlign.center,
                    ),
                    SpaceSizer(vertical: 2),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                      ),
                      child: RubikTextView(
                        value: 'Coba Lagi',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Cek data kosong
          if (frameController.historyList.isEmpty) {
            return Container(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history, size: 50, color: Colors.grey),
                    SpaceSizer(vertical: 2),
                    RubikTextView(
                      value: 'Belum ada history',
                      size: 14,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          }

          // Tampilkan data
          return SizedBox(
            width: SizeConfig.horizontal(100),
            height: SizeConfig.vertical(75),
            child: ListView.builder(
              itemCount: frameController.historyList.length,
              itemBuilder: (context, index) {
                final history = frameController.historyList[index];
                return RippleButton(
                  onTap: () => Get.to(
                    IndicationPartHistory(
                      frameController: frameController,
                      historyModel: history,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.horizontal(2),
                      horizontal: SizeConfig.horizontal(4),
                    ),
                    padding: EdgeInsets.all(SizeConfig.horizontal(4)),
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: SizeConfig.horizontal(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tanggal
                        RubikTextView(
                          value: history.createdAt,
                          fontWeight: FontWeight.w600,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          color: Colors.white,
                        ),
                        SpaceSizer(vertical: 1),
                        // Score
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildScoreItem('ADHD', history.adhdScore),
                            _buildScoreItem('ASD', history.asdScore),
                            _buildScoreItem(
                              'Disleksia',
                              history.disleksiaScore,
                            ),
                            _buildScoreItem(
                              'Tunagrahita',
                              history.tunagrahitaScore,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  // Helper widget untuk menampilkan score
  Widget _buildScoreItem(String label, double score) {
    return Column(
      children: [
        RubikTextView(
          value: label,
          size: SizeConfig.safeBlockHorizontal * 3,
          color: Colors.white70,
          fontWeight: FontWeight.w700,
        ),
        RubikTextView(
          value: '${score.toStringAsFixed(1)}%',
          size: SizeConfig.safeBlockHorizontal * 3.5,

          fontWeight: FontWeight.w600,
          color: _getScoreColor(score),
        ),
      ],
    );
  }

  // Helper untuk warna berdasarkan score
  Color _getScoreColor(double score) {
    if (score >= 70) return Colors.red;
    if (score >= 50) return Colors.orange;
    return Colors.green;
  }
}
