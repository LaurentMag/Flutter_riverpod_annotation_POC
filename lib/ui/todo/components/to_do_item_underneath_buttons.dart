import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/animated_icon_button.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class ToDoItemUnderneathButtons extends StatelessWidget {
  final bool isToDoDone;
  final bool isDeletionThresholdMet;
  final void Function() onToggleTap;
  final void Function() onDeleteTap;
  final double cardHeight;
  final double iconButtonsWidth;
  final double translationX;

  const ToDoItemUnderneathButtons({
    super.key,
    required this.isToDoDone,
    required this.isDeletionThresholdMet,
    required this.onToggleTap,
    required this.onDeleteTap,
    required this.cardHeight,
    required this.iconButtonsWidth,
    required this.translationX,
  });

  @override
  Widget build(BuildContext context) {
    final double checkButtonWidth = translationX < 0
        ? 0
        : translationX <= TodoSettings.iconButtonWidth
            ? TodoSettings.iconButtonWidth
            : translationX;

    final Color colorCheckButtonBackground = translationX > 0 && isToDoDone
        ? AppColors.checkedButton
        : AppColors.grayLightBg;

    final Color colorCheckIcon = translationX > 0 && isToDoDone
        ? AppColors.grayLight
        : AppColors.grayDark;

    final IconData iconCheckButton = translationX > 0 && isToDoDone
        ? Icons.check_circle_outline
        : Icons.circle_outlined;

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: AppColors.fixedCardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          //check button
          AnimatedIconButton(
            containerAnimationDuration:
                TodoSettings.animationDurationBottomCard,
            containerWidth: checkButtonWidth,
            containerBackgroundColor: colorCheckButtonBackground,
            icon: iconCheckButton,
            iconColor: colorCheckIcon,
            iconAlignment: Alignment.center,
            onIconTap: onToggleTap,
          ),
          const Spacer(),
          EditDeleteStack(
            translationXAbs: translationX.abs(),
            halfTranslationX: translationX.abs() / 2,
            isDeletionThresholdMet: isDeletionThresholdMet,
            onDeleteTap: onDeleteTap,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------

class EditDeleteStack extends StatelessWidget {
  final double translationXAbs;
  final double halfTranslationX;
  final bool isDeletionThresholdMet;
  final void Function() onDeleteTap;

  ///**EditDeleteStack** button position :
  ///
  ///```
  /// Stack(
  ///   row(EditButton - placeholder)
  ///       Positionned(DeleteButton)
  /// )
  ///```
  /// The `Stack` is used to have the `DeleteButton` **on top of** the `Row()` contaning the `EditButton` and the `placeholder`
  ///
  /// The `Positionned` widget is used to place the `DeleteButton` on the right side of the aviable space,
  /// which is defined by the `Row()` containing 2 widget
  const EditDeleteStack({
    super.key,
    required this.translationXAbs,
    required this.halfTranslationX,
    required this.isDeletionThresholdMet,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final double editDeleteWidth =
        halfTranslationX <= TodoSettings.iconButtonWidth
            ? TodoSettings.iconButtonWidth
            : halfTranslationX;

    return Stack(
      children: [
        Row(
          children: [
            // edit button
            AnimatedIconButton(
              containerAnimationDuration:
                  TodoSettings.animationDurationBottomCard,
              containerWidth: editDeleteWidth,
              containerBackgroundColor: AppColors.editButton,
              icon: Icons.edit_outlined,
              iconColor: AppColors.grayLight,
              iconAlignment: Alignment.center,
              onIconTap: () {},
            ),
            // placeholder
            AnimatedContainer(
              duration: const Duration(
                  milliseconds: TodoSettings.animationDurationBottomCard),
              width: editDeleteWidth,
            ),
          ],
        ),
        // delete button
        Positioned(
          right: 0,
          child: AnimatedIconButton(
            containerAnimationDuration: 100,
            containerWidth:
                setDynamicButtonWidth(translationXAbs, halfTranslationX),
            icon: Icons.delete_outline,
            containerBackgroundColor: AppColors.deleteButton,
            iconColor: AppColors.grayLight,
            iconAlignment: Alignment.center,
            onIconTap: onDeleteTap,
          ),
        ),
      ],
    );
  }
}

double setDynamicButtonWidth(double translationXAbs, double halfTranslation) {
// if the translationX is greater than the deleteThresholdDistance
  final bool isTranslationXExceedingThreshold =
      translationXAbs > TodoSettings.deleteThresholdDistance;

// if translation greater than the threshold, return the translationX as width, else return the half of the translationX like others buttons
  final double dynamicButtonWidth =
      isTranslationXExceedingThreshold ? translationXAbs : halfTranslation;

// return the maximum between the dynamicButtonWidth and the iconButtonWidth
  return max(dynamicButtonWidth, TodoSettings.iconButtonWidth);
}
