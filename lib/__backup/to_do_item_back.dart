import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_sliding_card.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_underneath_buttons.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_settings.dart';

class ToDoItem extends StatefulWidget {
  final ToDoModel toDo;
  final void Function() onDelete;
  final void Function() onToggle;

  const ToDoItem({
    super.key,
    required this.toDo,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  double translationX = 0;
  bool isDeletionThresholdMet = false;

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
  void didUpdateWidget(covariant ToDoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.toDo != widget.toDo) {
      resetTranslationX();
    }
  }

  void updateTranslationX(double value) {
    setState(() {
      translationX += value;
    });
  }

  /// Reset the card's position to the center
  void resetTranslationX() {
    setState(() {
      translationX = 0;
    });
  }

  /// Move the card to the limit of the button's width
  /// Allowing the card to be translated to the right or left and display buttons underneath
  void moveCardToButtonDisplayPosition(double limit) {
    setState(() {
      translationX = limit;
    });
  }

  void setDeletionThresholdState(bool value) {
    setState(() {
      isDeletionThresholdMet = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;

    rightTranslationLimit = maxwRightTranslCardWidthPct * cardWidth;
    leftTranslationLimit = maxLeftTranslCardWidthPct * cardWidth;
    deleteThresholdDistance = deleteThresholdCardWidthPct * cardWidth;

    return Stack(
      children: [
        ToDoItemUnderneathButtons(
          isToDoDone: widget.toDo.isDone,
          isDeletionThresholdMet: isDeletionThresholdMet,
          onToggleTap: widget.onToggle,
          onDeleteTap: widget.onDelete,
          cardHeight: toDoCardHeight,
          iconButtonsWidth: iconButtonWidth,
          currentXOffset: translationX,
        ),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            updateXOffsetOnDrag(
              details: details,
              currentXOffset: translationX,
              updateXOffset: updateTranslationX,
            );
          },
          onHorizontalDragEnd: (details) {
            final double velocity = details.velocity.pixelsPerSecond.dx;

            deleteTodoOnDragEnd(
              isDeletionThresholdReach: isDeletionThresholdMet,
              velocityX: velocity,
              setDeletionFlag: setDeletionThresholdState,
              onDelete: widget.onDelete,
            );

            setXOffsetToBtnWidthOnDragEnd(
              currentXOffset: translationX,
              setXOffset: moveCardToButtonDisplayPosition,
            );
            resetTopCardOnDragEnd(
              currentXOffset: translationX,
              resetXOffset: resetTranslationX,
            );
          },
          child: ToDoItemSlidingCard(
            cardHeight: toDoCardHeight,
            translationX: translationX,
            toDo: widget.toDo,
          ),
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
