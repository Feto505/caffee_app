import 'package:flutter/material.dart';

import '../../../../core/common/get_responsive_height_and_width.dart';
import '../../../../core/router/pages_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../data/mock_coffee_data.dart';


class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: coffeeItems.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final item = coffeeItems[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, PagesRoutes.itemDetailsScreen,arguments: item);
            },
            child: Container(
              decoration: BoxDecoration(
                // color: AppColors.greyDarkColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8),vertical: responsiveHeight(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.imagePath,
                            height: responsiveHeight(128),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(10), vertical: responsiveHeight(6)),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                bottomLeft: Radius.circular(12),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(0),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                Icon(AppIcons.favourite, color: AppColors.yellowColor, size: 16),
                                SizedBox(width: responsiveWidth(4)),
                                Text(
                                  item.rate.toString(),
                                  style: TextStyle(color:AppColors.whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: responsiveHeight(8)),
                  Text(
                      item.name,
                      style: AppTextStyles.Sora_600_16

                  ),
                  Text(
                      item.subTitle,
                      style: AppTextStyles.Sora_400_12.copyWith(
                          color: AppColors.lightWhiteColor
                      )
                  ),
                  SizedBox(height: responsiveHeight(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: AppTextStyles.Sora_600_18

                      ),
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor
                        ),
                        child: Center(
                          child: Icon(
                            AppIcons.addIcon,
                            color: AppColors.whiteColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    )
    ;
  }
}
