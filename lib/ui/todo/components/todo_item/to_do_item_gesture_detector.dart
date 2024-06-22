import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_settings.dart';

class ToDoItemGestureDetector extends StatefulWidget {
  final ToDoModel toDo;
  final void Function() onDelete;
  final void Function() onToggle;
  final Widget Function(bool isDeletionThresholdReached, double translationX)
      underneathButtonsBuilder;
  final Widget Function(double translationX) animatedToDoItemBuilder;

  /// A Widget wrapping a underneathCard containing :
  /// - card that can be translated via gestures
  /// - actions buttons
  ///
  /// The card can be translated to the right or left and display buttons underneath.
  /// It allow the user to delete or toggle the to-do item
  ///
  /// When translated the card lock the position at the button width to leave them visible.
  /// The translation can be reset by draggin the card between the button width and the edge
  ///
  /// The left of right action will be triggered by draggin the card to a certain limit to the right or left
  const ToDoItemGestureDetector(
      {super.key,
      required this.toDo,
      required this.onDelete,
      required this.onToggle,
      required this.underneathButtonsBuilder,
      required this.animatedToDoItemBuilder});

  @override
  State<ToDoItemGestureDetector> createState() =>
      _ToDoItemGestureDetectorState();
}

class _ToDoItemGestureDetectorState extends State<ToDoItemGestureDetector> {
  double _xGestureOffset = 0;

  /// distance to reach via gesture to be able to trigger the delete function
  bool _isDeletionThresholdReached = false;
  // card width can change based on the device screen size or window resize
  double _cardWidth = 0;

  /*
    Allow to reset the card's position to the center when one is deleted from the list
    Flutter's widget reuse mechanism. When you delete an item from the list, 
    Flutter tries to optimize performance by reusing the widget that was used to display the deleted item. 
    This can lead to unexpected behavior if the widget maintains state that is not properly reset when the widget is reused

    ensure that the moveX state is reset when the widget is reused. 
    You can do this by overriding the didUpdateWidget method in your _ToDoItemState class. 
    This method is called whenever the widget configuration changes 
    (i.e., when the widget is reused). In this method, you can reset the moveX state
  */
  @override
  void didUpdateWidget(covariant ToDoItemGestureDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.toDo != widget.toDo) {
      setXOffset(0);
    }
  }

  /// Update the card width and the settings based on the new value
  /// Updated on Build
  /// - `newValue`: The new card width value
  /// - `rightTranslationLimit`: The right translation limit for the toDo card, where the translation will be stopped
  /// - `leftTranslationLimit`: The left translation limit for the toDo card, where the translation will be stopped
  /// - `deleteThresholdDistance`: The distance threshold for the toDo card to be deleted while translating the card with a drag gesture
  void updateCardWidthAndSettings(double newValue) {
    // prevent useless calculation
    if (_cardWidth == newValue) return;

    _cardWidth = newValue;

    rightTranslationLimit = maxRightTranslCardWidthPct * _cardWidth;
    leftTranslationLimit = maxLeftTranslCardWidthPct * _cardWidth;
    deleteThresholdDistance = deleteThresholdCardWidthPct * _cardWidth;
  }

  void updateXOffset(double value) {
    setState(() {
      _xGestureOffset += value;
    });
  }

  void setXOffset(double value) {
    setState(() {
      _xGestureOffset = value;
    });
  }

  void setDeletionThresholdFlag(bool value) {
    _isDeletionThresholdReached = value;
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    updateCardWidthAndSettings(cardWidth);

    return Stack(
      children: [
        // TOP CARD  -----------------------------------
        widget.underneathButtonsBuilder(
            _isDeletionThresholdReached, _xGestureOffset),
        // GESTURE DETECTOR  -----------------------------------
        GestureDetector(
          // HORIZONTAL DRAG UPDATE
          onHorizontalDragUpdate: (details) {
            updateXOffsetOnDrag(
              currentXOffset: _xGestureOffset,
              updateXOffset: updateXOffset,
              details: details,
            );
            toggleTodoCompletionOnDrag(
              currentXOffset: _xGestureOffset,
              completionToggle: widget.onToggle,
            );
            setDeleteThresholdFlagOnDrag(
              currentXOffset: _xGestureOffset,
              setDeletionFlag: setDeletionThresholdFlag,
              isDeleteThresholdReached: _isDeletionThresholdReached,
            );
          },
          //HORIZONTAL DRAG END
          onHorizontalDragEnd: (details) {
            final double velocity = details.velocity.pixelsPerSecond.dx;

            deleteTodoOnDragEnd(
              velocityX: velocity,
              setDeletionFlag: setDeletionThresholdFlag,
              isDeletionThresholdReach: _isDeletionThresholdReached,
              onDelete: widget.onDelete,
            );
            setXOffsetToBtnWidthOnDragEnd(
              currentXOffset: _xGestureOffset,
              setXOffset: setXOffset,
            );
            resetTopCardOnDragEnd(
              currentXOffset: _xGestureOffset,
              resetXOffset: () => setXOffset(0),
            );
          },
          // UNDERNEATH CARD -----------------------------------
          child: widget.animatedToDoItemBuilder(_xGestureOffset),
        ),
      ],
    );
  }
}

// determine if the "todo completion" is permited using gesture movement.
bool isOnDragCompletionAllowed = true;

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
/// - `currentXOffset`: card offset on the X axis value.
/// - `updateXOffset`: A function that updates the translationX value.
void updateXOffsetOnDrag({
  required DragUpdateDetails details,
  required void Function(double) updateXOffset,
  required double currentXOffset,
}) {
  double moveValue = details.delta.dx * dragMoveSpeedMultiplier;

  if (_isBeyondLimit(currentXOffset, moveValue)) {
    // stop the movement
    return;
  }
  updateXOffset(moveValue);
}

/// If the card's XOffset is beyond a certain threshold, the `completionToggle` function is called.
///
/// "isCompletionAllowed" prevent the completionToggle function from being called multiple times.
/// Ensuring to be called only when pass the treshold and reset when back to the right.
///
/// It takes the following parameters:
/// - `completionToggle`: Function that toggle the todo completion.
/// - `currentXOffset`: card offset on the X axis value.
void toggleTodoCompletionOnDrag({
  required void Function() completionToggle,
  required double currentXOffset,
}) {
  double completionThresholdValue =
      rightTranslationLimit - completionThresholdDistance;

  if (isOnDragCompletionAllowed && currentXOffset > completionThresholdValue) {
    completionToggle();
    isOnDragCompletionAllowed = false;
  } else if (!isOnDragCompletionAllowed &&
      currentXOffset < completionThresholdValue) {
    isOnDragCompletionAllowed = true;
  }
}

/// if the XOffset is pass the threshold, set the value to true,
/// - `(currentXOffset < -deleteThresholdDistance)` means the card is dragged to the left, pass the treshold,
/// - (*negative XOffset value, therefore is below the treshold*)
/// - which allow to deleted the toDo via XOffset
///
/// if the XOffset is before the threshold, set the value to false,
/// - `(translationX > -deleteThresholdDistance)` means the card is dragged to the right, "*before*" the treshold,
/// - which prevent to deleted the toDo via XOffset
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
  required double velocityX,
  required bool isDeletionThresholdReach,
  required void Function(bool) setDeletionFlag,
  required void Function() onDelete,
}) {
  if (!isOnDragCompletionAllowed) isOnDragCompletionAllowed = true;

  if (isDeletionThresholdReach && velocityX.abs() < maxVelocityAllowed) {
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
  if (currentXOffset > leftButtonDisplayTreshold && currentXOffset > 0) {
    setXOffset(iconButtonWidth);
  }
  if (currentXOffset < -rightButtonDisplayTreshold && currentXOffset < 0) {
    setXOffset(-iconButtonWidth * 2);
  }
}

/// Resets the position of the top card when the drag ends.
///
/// This function is called when the drag event on the top card ends. It checks if the card's
/// horizontal XOffset is within certain thresholds.
/// If it is, the card's XOffset is reset.
///
///  ex :
///  ```
/// currentXOffset < leftButtonDisplayTreshold && xOffset > 0
/// // Check if the XOffset value is lower than the left button display threshold
/// // And checking for xOffset > 0 ensure to only consider the situation
/// // where the card is dragged to the right sames goes for the opposite check.
///  ```
/// Parameters:
///   - `currentXOffset`: The horizontal XOffset of the card. Positive values indicate a drag to the right,
///     negative values indicate a drag to the left.
///   - `resetxOffset`: A function that resets the horizontal XOffset of the card.
void resetTopCardOnDragEnd({
  required double currentXOffset,
  required void Function() resetXOffset,
}) {
  if (currentXOffset < leftButtonDisplayTreshold && currentXOffset > 0 ||
      currentXOffset > -rightButtonDisplayTreshold && currentXOffset < 0) {
    resetXOffset();
  }
}
