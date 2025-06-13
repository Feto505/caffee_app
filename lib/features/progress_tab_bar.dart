import 'package:coffee_app/core/common/get_responsive_height_and_width.dart';
import 'package:coffee_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressStepsBar extends StatelessWidget {
  final int activeStep;

  const ProgressStepsBar({super.key, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    const int totalSteps = 4;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(totalSteps, (index) {
          final isActive = index < activeStep;
      
          return Container(
            width: responsiveWidth(70),
            height: responsiveHeight(6),
            margin: EdgeInsets.symmetric(horizontal: responsiveWidth(4)),
            decoration: BoxDecoration(
              color: isActive ? AppColors.greenColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}
