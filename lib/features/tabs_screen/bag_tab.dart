import 'package:coffee_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BagTab extends StatelessWidget {
  const BagTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.yellowColor,
      child: Center(
        child: Text("bag screen"),
      ),
    );
  }
}
