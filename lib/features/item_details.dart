import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:coffee_app/core/utils/app_assets.dart';
import 'package:coffee_app/core/utils/app_colors.dart';
import 'package:coffee_app/core/utils/app_icons.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../data/coffee_item.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as CoffeeItem;
    const maxLinesCollapsed = 3;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24)),
            child: Icon(AppIcons.arrowBack),
          ),
        ),
        
        title: Text('Detail',style: AppTextStyles.Sora_600_16,),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24)),
            child: Image.asset(IconsAssets.favoriteIcon ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24),vertical: responsiveHeight(8)),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.imagePath,
                  height: responsiveHeight(202),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: responsiveHeight(8)),
              Text(item.name,style: AppTextStyles.Sora_600_20,),
              SizedBox(height: responsiveHeight(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.subTitle,style: AppTextStyles.Sora_400_12.copyWith(color: AppColors.lightWhiteColor),),
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.bicycle,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: responsiveWidth(8),),
                      Image.asset(IconsAssets.icon1),
                      SizedBox(width: responsiveWidth(8),),

                      Image.asset(
                        IconsAssets.icon2,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: responsiveWidth(8),),

                    ],
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(8)),

              Row(
                children: [
                  Icon(AppIcons.favourite, color: AppColors.yellowColor),
                  Text(item.rate.toString(),style: AppTextStyles.Sora_600_16,),
                ],
              ),
              Divider(color: AppColors.greyColor),
               Text('Description',style: AppTextStyles.Sora_600_14,),
              SizedBox(height: responsiveHeight(4)),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                firstChild: Text(
                  item.description,
                  maxLines: maxLinesCollapsed,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.Sora_300_14.copyWith(color: AppColors.lightWhiteColor),
                ),
                secondChild: Text(
                  item.description,
                  style: AppTextStyles.Sora_300_14.copyWith(color: AppColors.lightWhiteColor),
                ),
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Read Less' : 'Read More',
                  style: AppTextStyles.Sora_300_14.copyWith(color: AppColors.primaryColor,)

                ),
              ),
              SizedBox(height: responsiveHeight(16),),
              Text('Size',style: AppTextStyles.Sora_600_14,),
              SizedBox(height: responsiveHeight(16),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: responsiveHeight(6)),
                    width: responsiveWidth(96),
                    height: responsiveHeight(41),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightBrownColor,
                    ),
                    child: Text('S',textAlign: TextAlign.center,style: TextStyle(color: AppColors.primaryColor),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: responsiveHeight(6)),
                    width: responsiveWidth(96),
                    height: responsiveHeight(41),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightBrownColor,
                    ),
                    child: Text('M',textAlign: TextAlign.center,style: TextStyle(color: AppColors.primaryColor),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: responsiveHeight(6)),
                    width: responsiveWidth(96),
                    height: responsiveHeight(41),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightBrownColor,
                    ),
                    child: Text('L',textAlign: TextAlign.center,style: TextStyle(color: AppColors.primaryColor),),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(24),),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Price',style: AppTextStyles.Sora_400_14.copyWith(color: AppColors.greyColor),),
                      Text('\$${item.price.toStringAsFixed(2)}',style: AppTextStyles.Sora_600_18.copyWith(color: AppColors.primaryColor),),
                    ],
                  ),
                  SizedBox(width: responsiveWidth(56),),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: responsiveHeight(16)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text('Buy Now',style: TextStyle(color: AppColors.whiteColor),)),
                  )
                ],
              ),
              SizedBox(height: responsiveHeight(16),),


            ],
          ),
        ),
      ),
    );
  }
}
