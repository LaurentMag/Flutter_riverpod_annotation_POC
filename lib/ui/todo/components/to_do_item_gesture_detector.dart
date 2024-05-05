import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/card_movement_handler.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';

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
  double _translationX = 0;
  bool _isDeletionThresholdReached = false;

  double cardWidth = 0;

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
      setCardTranslation(0);
    }
  }

  void updateCardWidthAndSettings(double newValue) {
    if (cardWidth == newValue) return;
    cardWidth = newValue;

    TodoSettings.rightTranslationLimit =
        TodoSettings.maxwRightTranslCardWidthPct * cardWidth;
    TodoSettings.leftTranslationLimit =
        TodoSettings.maxLeftTranslCardWidthPct * cardWidth;
    TodoSettings.deleteThresholdDistance =
        TodoSettings.deleteThresholdCardWidthPct * cardWidth;
  }

  void updateTranslationX(double value) {
    setState(() {
      _translationX += value;
    });
  }

  void setCardTranslation(double value) {
    setState(() {
      _translationX = value;
    });
  }

  void setDeletionFlag(bool value) {
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
            _isDeletionThresholdReached, _translationX),
        GestureDetector(
          // HORIZONTAL DRAG UPDATE
          onHorizontalDragUpdate: (details) {
            CardMovementHandler.translationValueUpdateOnDrag(
              details: details,
              updateTranslationX: updateTranslationX,
              translationX: _translationX,
            );
            CardMovementHandler.toggleTodoOnDrag(
              completionToggle: widget.onToggle,
              translationX: _translationX,
            );
            CardMovementHandler.setThresholdFlagOnDrag(
              translationX: _translationX,
              isDeleteThresholdReached: _isDeletionThresholdReached,
              setDeletionFlag: setDeletionFlag,
            );
          },
          //HORIZONTAL DRAG END
          onHorizontalDragEnd: (details) {
            final double velocity = details.velocity.pixelsPerSecond.dx;

            CardMovementHandler.deleteTodoOnDragEnd(
              velocityX: velocity,
              setDeletionFlag: setDeletionFlag,
              isDeletionThresholdMet: _isDeletionThresholdReached,
              onDelete: widget.onDelete,
            );
            CardMovementHandler.setButtonsVisibleOnDragEnd(
              translationX: _translationX,
              setButtonsVisible: setCardTranslation,
            );
            CardMovementHandler.resetTopCardOnDragEnd(
              translationX: _translationX,
              resetTranslationX: () => setCardTranslation(0),
            );
          },
          // UNDERNEATH CARD
          child: widget.animatedToDoItemBuilder(_translationX),
        ),
      ],
    );
  }
}
