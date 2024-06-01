import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui_logic/to_do_item_logic.dart';
import 'package:flutter_new_riverpod_test/ui_logic/todo_settings.dart';

class ToDoItemGestureDetector extends StatefulWidget {
  final ToDoModel toDo;
  final void Function() onDelete;
  final void Function() onToggle;
  final Widget Function(bool isDeletionThresholdReached, double translationX)
      underneathButtonsBuilder;
  final Widget Function(double translationX) animatedToDoItemBuilder;

  /// A Widget wrapping a underneathCard containing actions buttons and a card that can be translated via gestures.
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
  bool _isDeletionThresholdReached = false;
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

  void updateCardWidthAndSettings(double newValue) {
    if (_cardWidth == newValue) return;
    _cardWidth = newValue;

    rightTranslationLimit = maxwRightTranslCardWidthPct * _cardWidth;
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
        // TOP CARD
        widget.underneathButtonsBuilder(
            _isDeletionThresholdReached, _xGestureOffset),
        GestureDetector(
          // HORIZONTAL DRAG UPDATE
          onHorizontalDragUpdate: (details) {
            updateXOffsetOnDrag(
              currentXOffset: _xGestureOffset,
              updateTranslationX: updateXOffset,
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
              isDeletionThresholdMet: _isDeletionThresholdReached,
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
          // UNDERNEATH CARD
          child: widget.animatedToDoItemBuilder(_xGestureOffset),
        ),
      ],
    );
  }
}






// // to_do_item_gesture_logic.dart
// class ToDoItemGestureLogic {
//   void updateXOffsetOnDrag(/* parameters */) {
//     // logic here
//   }

//   // other methods...
// }

// // to_do_item_gesture_detector.dart
// class _ToDoItemGestureDetectorState extends State<ToDoItemGestureDetector> {
//   final ToDoItemGestureLogic _logic = ToDoItemGestureLogic();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onHorizontalDragUpdate: (details) {
//         _logic.updateXOffsetOnDrag(/* parameters */);
//         // other calls...
//       },
//       // other callbacks...
//     );
//   }
// }