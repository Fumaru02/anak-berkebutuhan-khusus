import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SpaceSizer(vertical: 6),
            Row(
              children: [
                SpaceSizer(horizontal: 10),
                Image.asset(AssetList.moonIcon),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(6)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RubikTextView(
                      value: 'Test',
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      size: SizeConfig.safeBlockHorizontal * 6.5,
                    ),
                    Container(
                      width: SizeConfig.horizontal(12),
                      height: SizeConfig.vertical(12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.horizontal(90),
                  height: SizeConfig.horizontal(55),
                  decoration: BoxDecoration(
                    color: AppColors.maroon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.horizontal(1.5)),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RubikTextView(
                        value: 'Mulai deteksi anak berkebutuhan khusus',
                        size: SizeConfig.safeBlockHorizontal * 8.5,
                        fontWeight: FontWeight.w600,
                        alignText: AlignTextType.center,
                      ),
                      SpaceSizer(vertical: 2),
                      CustomFlatButton(
                        text: 'Mulai',
                        onTap: () {},
                        width: 45,
                        height: 4,
                        radius: 1,
                      ),
                    ],
                  ),
                ),
                SpaceSizer(vertical: 2),
                SizedBox(
                  height: SizeConfig.horizontal(100),
                  width: SizeConfig.vertical(100),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 60, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),

                    itemCount: 4, // total number of items
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red, // color of grid items
                              borderRadius: BorderRadius.all(
                                Radius.circular(SizeConfig.horizontal(1)),
                              ),
                            ),
                            height: SizeConfig.vertical(12),
                            child: Center(
                              child: Text(
                                'LOL',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          RubikTextView(value: 'LOOOOOOOOOOOOOOOOL'),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
