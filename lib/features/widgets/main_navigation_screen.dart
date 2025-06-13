import 'package:coffee_app/features/tabs_screen/bag_tab.dart';
import 'package:coffee_app/features/tabs_screen/favorite_tab.dart';
import 'package:coffee_app/features/tabs_screen/notifications_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../tabs_screen/home_screen/home_screen.dart';

class MainNavigationScreen extends HookWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    final pages = [
      const HomeScreen(),
      const FavoriteTab(),
      const BagTab(),
      const NotificationsTab(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.value,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(IconsAssets.bagIcon)),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(IconsAssets.notificationIcon)),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
