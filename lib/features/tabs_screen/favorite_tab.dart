import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greenColor,
      child: Center(
        child: Text("favorite screen"),
      ),
    );
  }
}
