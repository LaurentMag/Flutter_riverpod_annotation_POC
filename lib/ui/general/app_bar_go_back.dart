import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class AppBarGoBack extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.grayAppBarBg,
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
