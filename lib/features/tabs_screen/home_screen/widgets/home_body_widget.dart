import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:coffee_app/core/utils/app_assets.dart';
import 'package:coffee_app/core/utils/app_colors.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/features/tabs_screen/home_screen/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';

import 'grid_view_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Promo Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(ImageAssets.banner),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24),vertical: responsiveHeight(16)),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6)
                ),

                child: Text(
                  'Promo',
                  style: AppTextStyles.Sora_400_16.copyWith(color: AppColors.whiteColor),

                ),
              ),
              SizedBox(height: responsiveHeight(8)),
              Text(
                  'Buy one get\none FREE',
                  style: AppTextStyles.Sora_600_20.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 32,
                    height: 1.3,
                  )

              ),
            ],
          ),
        ),

        SizedBox(height: responsiveHeight(24)),

        // Tabs
        TabBarWidget(),

        // GridView
        GridViewWidget(),
      ],
    );
  }
}
