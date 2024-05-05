import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';

class CardMovementHandler {
  static bool isToggleActif = true;

  static const double toggleThresholdOffset = 5;

  static const double checkButtonDisplayFactor = 0.6;
  static const double doubleButtonDisplayFactor = 0.9;

  static const double leftButtonDisplayTreshold =
      TodoSettings.iconButtonWidth * checkButtonDisplayFactor;
  static const double rightButtonDisplayTreshold =
      TodoSettings.iconButtonWidth * doubleButtonDisplayFactor;

  /// Check if the card's translation is beyond the limit
  ///  checking if moveValue also is positive prevent the same direction. While going back, make the moveValue be neg
  /// therefore allow to return to the center
  /// (i.e : Going to left, moveValue is +, when reach limit, cant go further, but can move back to right as moveValue is - )
  static bool _isBeyondLimit(double translationX, double moveValue) {
    return (translationX > TodoSettings.rightTranslationLimit &&
            moveValue > 0) ||
        (translationX < -TodoSettings.leftTranslationLimit && moveValue < 0);
  }

  /// Calculates **move value** *based on the delta of the drag details* and a set **speed factor** (to limit movement speed).
  /// If the card is moved beyond a certain limit, stop the movement.
  ///
  /// - `details`: A [DragUpdateDetails] object that contains information about the drag update.
  /// - `translationX`: card translation on the X axis value.
  /// - `updateTranslationX`: A function that updates the translationX value.
  static void translationValueUpdateOnDrag({
    required DragUpdateDetails details,
    required void Function(double) updateTranslationX,
    required double translationX,
  }) {
    double moveValue = details.delta.dx * TodoSettings.dragMoveSpeedMultiplier;

    if (_isBeyondLimit(translationX, moveValue)) {
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
  static void toggleTodoOnDrag({
    required void Function() completionToggle,
    required double translationX,
  }) {
    double toggleTranslationTreshold =
        TodoSettings.rightTranslationLimit - toggleThresholdOffset;

    if (isToggleActif && translationX > toggleTranslationTreshold) {
      completionToggle();
      isToggleActif = false;
    } else if (!isToggleActif && translationX < toggleTranslationTreshold) {
      isToggleActif = true;
    }
  }

  /// if the translation is pass the threshold, set the value to true,
  /// - `(translationX < -TodoSettings.deleteThresholdDistance)` means the card is dragged to the left, pass the treshold,
  /// - (*negative translation value, therefore is below the treshold*)
  /// - which allow to deleted the toDo via translation
  ///
  /// if the translation is before the threshold, set the value to false,
  /// - `(translationX > -TodoSettings.deleteThresholdDistance)` means the card is dragged to the right, "*before*" the treshold,
  /// - which prevent to deleted the toDo via translation
  static void setThresholdFlagOnDrag({
    required double translationX,
    required bool isDeleteThresholdReached,
    required void Function(bool) setDeletionFlag,
  }) {
    if (!isDeleteThresholdReached &&
        translationX < -TodoSettings.deleteThresholdDistance) {
      setDeletionFlag(true);
    }
    if (isDeleteThresholdReached &&
        translationX > -TodoSettings.deleteThresholdDistance) {
      setDeletionFlag(false);
    }
  }

  /// Given the user's drag gesture, check if the user wants to delete the toDo
  /// If the user's drag gesture goes over the delete threshold distance, and the velocity is not too high, delete the toDo
  /// Otherwise, reset the delete gesture flag.
  static void deleteTodoOnDragEnd({
    required bool isDeletionThresholdMet,
    required double velocityX,
    required void Function() onDelete,
    required void Function(bool) setDeletionFlag,
  }) {
    if (!isToggleActif) isToggleActif = true;

    if (isDeletionThresholdMet &&
        velocityX.abs() < TodoSettings.maxVelocityAllowed) {
      onDelete();
    } else {
      setDeletionFlag(false);
    }
  }

  /// determine the toDo card's position based on the user's drag gesture direction,
  /// And set the buttons visible.
  static void setButtonsVisibleOnDragEnd({
    required double translationX,
    required void Function(double) setButtonsVisible,
  }) {
    const double btnWidth = TodoSettings.iconButtonWidth;

    if (translationX > leftButtonDisplayTreshold && translationX > 0) {
      setButtonsVisible(btnWidth);
    }
    if (translationX < -rightButtonDisplayTreshold && translationX < 0) {
      setButtonsVisible(-btnWidth * 2);
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
  /// translationX < leftButtonDisplayTreshold && translationX > 0
  /// // Check if the translation value is lower than the left button display threshold
  /// // And checking for translationX > 0 ensure to only consider the situation where the card is dragged to the right
  /// // sames goes for the opposite check.
  ///  ```
  /// Parameters:
  ///   - `translationX`: The horizontal translation of the card. Positive values indicate a drag to the right,
  ///     negative values indicate a drag to the left.
  ///   - `resetTranslationX`: A function that resets the horizontal translation of the card.
  static void resetTopCardOnDragEnd({
    required double translationX,
    required void Function() resetTranslationX,
  }) {
    if (translationX < leftButtonDisplayTreshold && translationX > 0 ||
        translationX > -rightButtonDisplayTreshold && translationX < 0) {
      resetTranslationX();
    }
  }
}
