import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/animated_icon_button.dart';
import 'package:flutter_new_riverpod_test/ui_logic/to_do_item_logic.dart';
import 'package:flutter_new_riverpod_test/ui_logic/todo_settings.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class ToDoItemUnderneathButtons extends StatelessWidget {
  final bool isToDoDone;
  final bool isDeletionThresholdMet;
  final void Function() onToggleTap;
  final void Function() onDeleteTap;
  final double cardHeight;
  final double iconButtonsWidth;
  final double currentXOffset;

  const ToDoItemUnderneathButtons({
    super.key,
    required this.isToDoDone,
    required this.isDeletionThresholdMet,
    required this.onToggleTap,
    required this.onDeleteTap,
    required this.cardHeight,
    required this.iconButtonsWidth,
    required this.currentXOffset,
  });

  @override
  Widget build(BuildContext context) {
    final double checkButtonWidth = currentXOffset < 0
        ? 0
        : currentXOffset <= iconButtonWidth
            ? iconButtonWidth
            : currentXOffset;

    final Color colorCheckButtonBackground = currentXOffset > 0 && isToDoDone
        ? AppColors.checkedButton
        : AppColors.grayLightBg;

    final Color colorCheckIcon = currentXOffset > 0 && isToDoDone
        ? AppColors.grayLight
        : AppColors.grayDark;

    final IconData iconCheckButton = currentXOffset > 0 && isToDoDone
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
            animationDuration: animationDurationBottomCard,
            containerWidth: checkButtonWidth,
            containerBackgroundColor: colorCheckButtonBackground,
            icon: iconCheckButton,
            iconColor: colorCheckIcon,
            iconAlignment: Alignment.center,
            onIconTap: onToggleTap,
          ),
          const Spacer(),
          EditDeleteStack(
            currentXOffsetAbs: currentXOffset.abs(),
            halfCurrentXOffset: currentXOffset.abs() / 2,
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
  final double currentXOffsetAbs;
  final double halfCurrentXOffset;
  final bool isDeletionThresholdMet;
  final void Function() onDeleteTap;

  ///**EditDeleteStack** button position :
  ///
  ///```
  /// Stack(
  ///   row| EditButton  |              placeholder |
  ///                    | Positionned(DeleteButton |
  /// )
  ///```
  /// The `Stack` is used to have the `DeleteButton` **on top of** the `Row()` contaning the `EditButton` and the `placeholder`
  ///
  /// The `Positionned` widget is used to place the `DeleteButton` on the right side of the aviable space,
  /// which is defined by the `Row()` containing 2 widget
  const EditDeleteStack({
    super.key,
    required this.currentXOffsetAbs,
    required this.halfCurrentXOffset,
    required this.isDeletionThresholdMet,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    /// determine based on the XOffset if the button will use his default width
    /// Or "stretch" based on the 1/2 XOffset value (as we need to display 2 Btn side to side)
    final double editButtonWidth = halfCurrentXOffset <= iconButtonWidth
        ? iconButtonWidth
        : halfCurrentXOffset;

    return Stack(
      children: [
        Row(
          children: [
            // edit button
            AnimatedIconButton(
              animationDuration: animationDurationBottomCard,
              containerWidth: editButtonWidth,
              containerBackgroundColor: AppColors.editButton,
              icon: Icons.edit_outlined,
              iconColor: AppColors.grayLight,
              iconAlignment: Alignment.center,
              onIconTap: () {},
            ),
            // placeholder
            AnimatedContainer(
              duration:
                  const Duration(milliseconds: animationDurationBottomCard),
              width: editButtonWidth,
            ),
          ],
        ),
        // delete button
        Positioned(
          right: 0,
          child: AnimatedIconButton(
            animationDuration: 100,
            containerWidth: changeBtnWidthBasedOnThreshold(
                currentXOffsetAbs, halfCurrentXOffset),
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
