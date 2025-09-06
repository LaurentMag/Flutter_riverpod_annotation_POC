import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class ElevatedButtonStyle {
  //
  static final ButtonStyle navigationButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(
        color: AppColors.cardBorder,
        width: 1,
      ),
    ),
    foregroundColor: AppColors.grayDark,
    backgroundColor: AppColors.grayAppBarBg,
    elevation: 0,
  );
}
