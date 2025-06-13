import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:coffee_app/core/router/pages_routes.dart';
import 'package:coffee_app/core/utils/app_assets.dart';
import 'package:coffee_app/core/utils/app_colors.dart';
import 'package:coffee_app/core/utils/app_icons.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../data/coffee_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as CoffeeItem;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text('Order', style: AppTextStyles.Sora_600_16),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(AppIcons.arrowBack),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(16),
          vertical: responsiveHeight(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deliver & Pickup Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Deliver",
                      style: AppTextStyles.Sora_600_16.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFDADADA)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Pick Up",
                      style: AppTextStyles.Sora_400_16.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsiveHeight(24)),

            // Delivery Address
            Text("Delivery Address", style: AppTextStyles.Sora_600_16),
            SizedBox(height: 8),
            Text("Jl. Kpg Sutoyo", style: AppTextStyles.Sora_600_14),
            Text(
              "Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.",
              style: AppTextStyles.Sora_400_12.copyWith(
                color: AppColors.lightWhiteColor,
              ),
            ),
            SizedBox(height: responsiveHeight(16)),
            Row(
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(minimumSize: Size(0, 30)),
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage(IconsAssets.editIcon),
                    color: AppColors.g2Color,
                  ),
                  label: Text(
                    "Edit Address",
                    style: AppTextStyles.Sora_400_12.copyWith(
                      color: AppColors.g2Color,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(minimumSize: Size(0, 30)),
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage(IconsAssets.documentIcon),
                    color: AppColors.g2Color,
                  ),
                  label: Text(
                    "Add Note",
                    style: AppTextStyles.Sora_400_12.copyWith(
                      color: AppColors.g2Color,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: responsiveHeight(24)),

            // Item
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.imagePath,
                    width: responsiveWidth(54),
                    height: responsiveHeight(54),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: responsiveWidth(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: AppTextStyles.Sora_600_16),
                      SizedBox(height: 4),
                      Text(
                        item.subTitle,
                        style: AppTextStyles.Sora_400_12.copyWith(
                          color: AppColors.lightWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text('-', style: AppTextStyles.Sora_700_20),
                    ),
                    SizedBox(width: responsiveWidth(8)),
                    const Text("1"),
                    SizedBox(width: responsiveWidth(8)),
                    InkWell(
                      onTap: () {},
                      child: Text('+', style: AppTextStyles.Sora_700_20),
                    ),
                  ],
                ),
                SizedBox(width: responsiveWidth(16)),
              ],
            ),
            SizedBox(height: responsiveHeight(16)),
            // Discount
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // border: Border.all(color: AppColors.lightWhiteColor),
                color: const Color(0xFFF6F6F6),

              ),

              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(12),
                vertical: responsiveHeight(16),
              ),
              child: Row(
                children: [
                  Image.asset(IconsAssets.discountIcon),
                  SizedBox(width: responsiveWidth(12)),
                  Expanded(
                    child: Text(
                      "1 Discount is Applies",
                      style: AppTextStyles.Sora_600_14,
                    ),
                  ),
                  Icon(AppIcons.arrowRight, size: 16),
                ],
              ),
            ),
            SizedBox(height: responsiveHeight(24)),

            // Payment Summary
            Text("Payment Summary", style: AppTextStyles.Sora_600_16),
            SizedBox(height: responsiveHeight(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price",style: AppTextStyles.Sora_400_12,),
                Text("\$ ${item.price}", style: AppTextStyles.Sora_600_14,)
              ],
            ),
            SizedBox(height: responsiveHeight(4),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Fee",style: AppTextStyles.Sora_400_12,),
                Row(
                  children: [
                    Text(
                      "\$ 2.0",
                      style:
                      TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text("\$ 1.0",style: AppTextStyles.Sora_600_14,),
                  ],
                ),
              ],
            ),
             SizedBox(height: responsiveHeight(24)),

            // Payment Method
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF6F6F6),
              ),
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(12), vertical: responsiveHeight(16)),
              child: Row(
                children: [
                  Image.asset(IconsAssets.walletIcon),
                  SizedBox(width: responsiveWidth(16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cash/Wallet",
                          style: AppTextStyles.Sora_600_14
                        ),
                        Text("\$ ${item.price+1.0}",style: AppTextStyles.Sora_600_12.copyWith(color: AppColors.primaryColor),),
                      ],
                    ),
                  ),

                  Icon(AppIcons.arrowDown),
                ],
              ),
            ),
            SizedBox(height: responsiveHeight(24)),

            // Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PagesRoutes.mainMapScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: responsiveHeight(16)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Order",
                  style:AppTextStyles.Sora_600_16.copyWith(color: AppColors.whiteColor)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
