import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:coffee_app/features/tabs_screen/home_screen/widgets/app_bar_home_widget.dart';
import 'package:coffee_app/features/tabs_screen/home_screen/widgets/container_home_widget.dart';
import 'package:coffee_app/features/tabs_screen/home_screen/widgets/home_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/utils/app_colors.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          ContainerHomeWidget(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24), vertical: responsiveHeight(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarHomeWidget(),
                  Expanded(child: HomeBodyWidget()),

                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: MainNavigationScreen()
    );
  }
}
