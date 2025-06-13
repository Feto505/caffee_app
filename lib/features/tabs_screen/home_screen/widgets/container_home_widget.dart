import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';


class ContainerHomeWidget extends StatelessWidget {
  const ContainerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.centerRight,
          radius: 0.9,
          colors: [AppColors.g1Color, AppColors.g2Color],
        ),
      ),
    );
  }
}
