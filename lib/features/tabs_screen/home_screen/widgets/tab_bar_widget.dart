import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';


class TabBarWidget extends HookWidget {
  const TabBarWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final categories = ['All Coffee', 'Macchiato', 'Latte', 'Americano'];
    final selectedTab = useState(0);

    return Column(
      children: [
        SizedBox(
          height: responsiveHeight(29),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final isSelected = selectedTab.value == index;
              return Padding(
                padding: EdgeInsets.only(right: responsiveWidth(8)),
                child: GestureDetector(
                  onTap: () => selectedTab.value = index,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: responsiveWidth(12)),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                        categories[index],
                        style:AppTextStyles.Sora_400_14.copyWith(
                          color: isSelected
                              ? AppColors.whiteColor
                              : AppColors.greyDarkColor,
                        )
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: responsiveHeight(16)),
      ],
    );
  }
}
