import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:coffee_app/core/router/pages_routes.dart';
import 'package:coffee_app/core/utils/app_icons.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/utils/app_colors.dart';
import '../core/utils/app_assets.dart';
import '../data/mock_coffee_data.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final selectedTab = useState(0);

    final categories = ['All Coffee', 'Macchiato', 'Latte', 'Americano'];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.centerRight,
                radius: 0.9,
                colors: [AppColors.g1Color, AppColors.g2Color],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24), vertical: responsiveHeight(24)),
              child: Column(
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

                  // GridView
                  Expanded(
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.whiteColor,
        currentIndex: selectedTab.value,
        onTap: (index) => selectedTab.value = index,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.lightWhiteColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(IconsAssets.favoriteIcon)),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(IconsAssets.bagIcon)),
            label: 'bag',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(IconsAssets.notificationIcon)),
            label: 'notification',
          ),
        ],
      ),
    );
  }
}
