import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyDarkColor,
      child: Center(
        child: Text("NotificationsTab screen"),
      ),
    );  }
}
