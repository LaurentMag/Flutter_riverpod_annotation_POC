import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class AnimatedIconButton extends StatelessWidget {
  final int containerAnimationDuration;
  final Color containerBackgroundColor;
  final double containerWidth;
  final IconData icon;
  final Color iconColor;
  final Alignment iconAlignment;
  final void Function() onIconTap;

  const AnimatedIconButton({
    super.key,
    required this.containerAnimationDuration,
    required this.containerBackgroundColor,
    required this.containerWidth,
    required this.icon,
    required this.iconColor,
    required this.iconAlignment,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: containerAnimationDuration),
      height: TodoSettings.toDoCardHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.fixedCardBackground,
          width: 2,
        ),
      ),
      child: Align(
        alignment: iconAlignment,
        child: IconButton(
          onPressed: onIconTap,
          iconSize: 28,
          color: iconColor,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
