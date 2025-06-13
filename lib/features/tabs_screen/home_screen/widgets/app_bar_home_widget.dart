import 'package:flutter/material.dart';

import '../../../../core/common/get_responsive_height_and_width.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/text_styles.dart';


class AppBarHomeWidget extends StatelessWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Location',
                style: AppTextStyles.Sora_400_12.copyWith(color: AppColors.lightWhiteColor)
            ),
            SizedBox(height: responsiveHeight(4)),
            Row(
              children: [
                Text(
                    'Bilzen, Tanjungbalai',
                    style: AppTextStyles.Sora_600_14.copyWith(color: AppColors.whiteColor)
                ),
                Icon(
                  AppIcons.arrowDown,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: responsiveHeight(24)),
        // Search & Filter
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
                decoration: BoxDecoration(
                  color: AppColors.lightWhite2Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: TextStyle(color: AppColors.whiteColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search coffee',
                    hintStyle:AppTextStyles.Sora_400_14.copyWith(color: AppColors.lightWhiteColor),
                    icon: Icon(
                      AppIcons.searchIcon,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: responsiveWidth(12)),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(12),vertical: responsiveHeight(12)),
              child: const Icon(
                AppIcons.filterIcon,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        SizedBox(height: responsiveHeight(24)),

      ],
    );
  }
}
