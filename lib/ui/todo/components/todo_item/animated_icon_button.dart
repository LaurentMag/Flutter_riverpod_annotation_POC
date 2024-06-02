import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_settings.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class AnimatedIconButton extends StatelessWidget {
  final int animationDuration;
  final Color containerBackgroundColor;
  final double containerWidth;
  final Alignment iconAlignment;
  final IconData icon;
  final Color iconColor;
  final void Function() onIconTap;

  const AnimatedIconButton({
    super.key,
    required this.animationDuration,
    required this.containerBackgroundColor,
    required this.containerWidth,
    required this.iconAlignment,
    required this.icon,
    required this.iconColor,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animationDuration),
      height: toDoCardHeight,
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
