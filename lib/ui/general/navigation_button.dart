import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class NavigationButton extends StatelessWidget {
  final String buttonText;
  final Function action;

  const NavigationButton({
    super.key,
    required this.buttonText,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              action();
            },
            style: ElevatedButtonStyle.navigationButtonStyle,
            child: Text(buttonText)),
      ),
    );
  }
}

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
