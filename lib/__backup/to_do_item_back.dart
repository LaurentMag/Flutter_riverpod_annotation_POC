import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item_top_animated.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/card_movement_handler.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item_underneath_buttons.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';

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

    TodoSettings.rightTranslationLimit =
        TodoSettings.maxwRightTranslCardWidthPct * cardWidth;
    TodoSettings.leftTranslationLimit =
        TodoSettings.maxLeftTranslCardWidthPct * cardWidth;
    TodoSettings.deleteThresholdDistance =
        TodoSettings.deleteThresholdCardWidthPct * cardWidth;

    return Stack(
      children: [
        ToDoItemUnderneathButtons(
          isToDoDone: widget.toDo.isDone,
          isDeletionThresholdMet: isDeletionThresholdMet,
          onToggleTap: widget.onToggle,
          onDeleteTap: widget.onDelete,
          cardHeight: TodoSettings.toDoCardHeight,
          iconButtonsWidth: TodoSettings.iconButtonWidth,
          translationX: translationX,
        ),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            CardMovementHandler.translationValueUpdateOnDrag(
              details: details,
              translationX: translationX,
              updateTranslationX: updateTranslationX,
            );
          },
          onHorizontalDragEnd: (details) {
            final double velocity = details.velocity.pixelsPerSecond.dx;

            CardMovementHandler.deleteTodoOnDragEnd(
              isDeletionThresholdMet: isDeletionThresholdMet,
              velocityX: velocity,
              setDeletionFlag: setDeletionThresholdState,
              onDelete: widget.onDelete,
            );

            CardMovementHandler.setButtonsVisibleOnDragEnd(
              translationX: translationX,
              setButtonsVisible: moveCardToButtonDisplayPosition,
            );
            CardMovementHandler.resetTopCardOnDragEnd(
              translationX: translationX,
              resetTranslationX: resetTranslationX,
            );
          },
          child: ToDoItemTopAnimated(
            cardHeight: TodoSettings.toDoCardHeight,
            translationX: translationX,
            toDo: widget.toDo,
          ),
        ),
      ],
    );
  }
}
