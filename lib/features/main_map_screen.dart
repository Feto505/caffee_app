import 'package:coffee_app/core/utils/app_icons.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/features/progress_tab_bar.dart';
import 'package:coffee_app/features/route_view.dart';
import 'package:flutter/material.dart';


import '../core/common/get_responsive_height_and_width.dart';
import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';

class MainMapScreen extends StatelessWidget {
  const MainMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 65,
            child: MapScreen(),
          ),
          Flexible(
            flex: 35,
            child: Column(
              children: [
                SizedBox(height: responsiveHeight(4),),
                Center(
                  child: Container(
                    width: responsiveWidth(120),
                    height: responsiveHeight(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: responsiveHeight(16),),
                Column(
                  children: [
                    Text("10 minutes left",style: AppTextStyles.Sora_600_16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Delivery to",style: AppTextStyles.Sora_400_12,),
                        Text(" Jl. Kpg Sutoyo",style: AppTextStyles.Sora_600_12,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: responsiveHeight(16),),
                ProgressStepsBar(activeStep: 3,),
                SizedBox(height: responsiveHeight(16),),
                Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: const Color(0xFFF6F6F6),
                border: Border.all(color: AppColors.greyColor)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: responsiveHeight(8)),
                      child: Image.asset(IconsAssets.bicycle,width: responsiveWidth(56),height: responsiveHeight(56),),
                    ),
                    SizedBox(width: responsiveWidth(16),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivered your order',style: AppTextStyles.Sora_600_14,),
                        Text('We will deliver your goods to you in \n the shortes possible time.',style: AppTextStyles.Sora_400_12.copyWith(color: AppColors.lightWhiteColor),),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: responsiveHeight(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF6F6F6),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: responsiveHeight(8)),
                      child: Image.asset(ImageAssets.image1,width: responsiveWidth(56),height: responsiveHeight(56),),
                    ),
                    SizedBox(width: responsiveWidth(16),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Faten Khalid',style: AppTextStyles.Sora_600_14,),
                        Text('Personal Courier',style: AppTextStyles.Sora_400_12.copyWith(color: AppColors.lightWhiteColor),),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8),vertical: responsiveHeight(4)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.whiteColor
                      ),
                
                      child: Icon(AppIcons.phoneIcon),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
