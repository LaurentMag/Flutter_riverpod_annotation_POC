import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui_logic/todo_settings.dart';

bool isToggleActif = true;

const double toggleThresholdOffset = 5;
const double checkButtonDisplayFactor = 0.6;
const double doubleButtonDisplayFactor = 0.9;

const double leftButtonDisplayTreshold =
    iconButtonWidth * checkButtonDisplayFactor;
const double rightButtonDisplayTreshold =
    iconButtonWidth * doubleButtonDisplayFactor;

/// Check if the card's translation is beyond the limit
///  checking if moveValue also is positive prevent the same direction. While going back, make the moveValue be neg
/// therefore allow to return to the center
/// (i.e : Going to left, moveValue is +, when reach limit, cant go further, but can move back to right as moveValue is - )
bool _isBeyondLimit(double currentXOffset, double moveValue) {
  return (currentXOffset > rightTranslationLimit && moveValue > 0) ||
      (currentXOffset < -leftTranslationLimit && moveValue < 0);
}

/// Calculates **move value** *based on the delta of the drag details* and a set **speed factor** (to limit movement speed).
/// If the card is moved beyond a certain limit, stop the movement.
///
/// - `details`: A [DragUpdateDetails] flutter object that contains information about the drag update.
/// - `translationX`: card translation on the X axis value.
/// - `updateTranslationX`: A function that updates the translationX value.
void updateXOffsetOnDrag({
  required DragUpdateDetails details,
  required void Function(double) updateTranslationX,
  required double currentXOffset,
}) {
  double moveValue = details.delta.dx * dragMoveSpeedMultiplier;

  if (_isBeyondLimit(currentXOffset, moveValue)) {
    // stop the movement
    return;
  }
  updateTranslationX(moveValue);
}

/// If the card's translation is beyond a certain threshold, the `completionToggle` function is called.
///
/// User class "isToggleActif" to prevent the completionToggle function from being called multiple times.
/// Ensuring to be called only when pass the treshold and reset when back to the right.
///
/// It takes the following parameters:
/// - `completionToggle`: Function that toggle the todo completion.
/// - `translationX`: card translation on the X axis value.
void toggleTodoCompletionOnDrag({
  required void Function() completionToggle,
  required double currentXOffset,
}) {
  double toggleTranslationTreshold =
      rightTranslationLimit - toggleThresholdOffset;

  if (isToggleActif && currentXOffset > toggleTranslationTreshold) {
    completionToggle();
    isToggleActif = false;
  } else if (!isToggleActif && currentXOffset < toggleTranslationTreshold) {
    isToggleActif = true;
  }
}

/// if the translation is pass the threshold, set the value to true,
/// - `(translationX < -deleteThresholdDistance)` means the card is dragged to the left, pass the treshold,
/// - (*negative translation value, therefore is below the treshold*)
/// - which allow to deleted the toDo via translation
///
/// if the translation is before the threshold, set the value to false,
/// - `(translationX > -deleteThresholdDistance)` means the card is dragged to the right, "*before*" the treshold,
/// - which prevent to deleted the toDo via translation
void setDeleteThresholdFlagOnDrag({
  required double currentXOffset,
  required bool isDeleteThresholdReached,
  required void Function(bool) setDeletionFlag,
}) {
  if (!isDeleteThresholdReached && currentXOffset < -deleteThresholdDistance) {
    setDeletionFlag(true);
  }
  if (isDeleteThresholdReached && currentXOffset > -deleteThresholdDistance) {
    setDeletionFlag(false);
  }
}

/// Given the user's drag gesture, check if the user wants to delete the toDo
/// If the user's drag gesture goes over the delete threshold distance, and the velocity is not too high, delete the toDo
/// Otherwise, reset the delete gesture flag.
void deleteTodoOnDragEnd({
  required bool isDeletionThresholdMet,
  required double velocityX,
  required void Function() onDelete,
  required void Function(bool) setDeletionFlag,
}) {
  if (!isToggleActif) isToggleActif = true;

  if (isDeletionThresholdMet && velocityX.abs() < maxVelocityAllowed) {
    onDelete();
  } else {
    setDeletionFlag(false);
  }
}

/// On drag end, based on the offset,
/// If the offet has passed a certain distance use the underneath button width value as X offset.
/// Allowing to have the buttons visible without having to keep drag the card.
///
/// `On Drag End : `
/// * IF move toward right (*positive offsetv value*), and if currentXOffset goes hover a set limit, set offset value to btn width
/// * IF move toward left (*negative offset value*), and if currentXOffset goes hover a set limit, set offset value to -btn width
void setXOffsetToBtnWidthOnDragEnd({
  required double currentXOffset,
  required void Function(double) setXOffset,
}) {
  const double btnWidth = iconButtonWidth;

  if (currentXOffset > leftButtonDisplayTreshold && currentXOffset > 0) {
    setXOffset(btnWidth);
  }
  if (currentXOffset < -rightButtonDisplayTreshold && currentXOffset < 0) {
    setXOffset(-btnWidth * 2);
  }
}

/// Resets the position of the top card when the drag ends.
///
/// This function is called when the drag event on the top card ends. It checks if the card's
/// horizontal translation is within certain thresholds.
/// If it is, the card's translation is reset.
///
///  ex :
///  ```
/// xOffset < leftButtonDisplayTreshold && xOffset > 0
/// // Check if the translation value is lower than the left button display threshold
/// // And checking for xOffset > 0 ensure to only consider the situation
/// // where the card is dragged to the right sames goes for the opposite check.
///  ```
/// Parameters:
///   - `xOffset`: The horizontal translation of the card. Positive values indicate a drag to the right,
///     negative values indicate a drag to the left.
///   - `resetxOffset`: A function that resets the horizontal translation of the card.
void resetTopCardOnDragEnd({
  required double currentXOffset,
  required void Function() resetXOffset,
}) {
  if (currentXOffset < leftButtonDisplayTreshold && currentXOffset > 0 ||
      currentXOffset > -rightButtonDisplayTreshold && currentXOffset < 0) {
    resetXOffset();
  }
}

/// During gesture :
///
/// Determine if the offset value is greater than the "delete threshold"
/// (*limit when release the drag will trigger a delete function*)
///
/// `If` it is, it will change the button width to use the currentXOffset value, meaning it will fill the entier avialable space
/// from the border of the card to the translating border card.
///
/// `Else` the button width will use half of the current XOffset.
double changeBtnWidthBasedOnThreshold(
    double currentXOffsetAbs, double halfXOffset) {
// if the translationX is greater than the deleteThresholdDistance
  final bool isTranslationXExceedingThreshold =
      currentXOffsetAbs > deleteThresholdDistance;

// if translation greater than the threshold, return the translationX as width, else return the half of the translationX like others buttons
  final double dynamicButtonWidth =
      isTranslationXExceedingThreshold ? currentXOffsetAbs : halfXOffset;

// return the maximum between the dynamicButtonWidth and the iconButtonWidth
  return max(dynamicButtonWidth, iconButtonWidth);
}
