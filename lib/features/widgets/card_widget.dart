import 'package:flutter/material.dart';

import '../../../../../core/common/get_responsive_height_and_width.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../core/utils/app_colors.dart';

class AddressDetailsSection extends StatelessWidget {
  const AddressDetailsSection({
    super.key,
    required this.name,
    required this.address,
    this.image,
  });

  final String name;
  final String address;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: responsiveHeight(80),
          padding: EdgeInsets.only(
            left: responsiveWidth(4),
            bottom: responsiveHeight(8),
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),

          ),
          child: ListTile(
            leading: SizedBox(
              width: responsiveWidth(50),
              height: responsiveHeight(50),
              child: Image.asset(ImageAssets.image1),
            ),
            title: Text(
              name,
              style: AppTextStyles.Sora_400_14.copyWith(color: AppColors.greyDarkColor),
            ),
            subtitle: Row(
              children: [
                SizedBox(width: responsiveWidth(2)),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    address,
                    style: AppTextStyles.Sora_400_14.copyWith(color: AppColors.blackColor),
                  ),
                ),
              ],
            ),

          ),
        )
      ],
    );
  }

}
