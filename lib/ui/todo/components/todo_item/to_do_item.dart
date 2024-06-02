import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_gesture_detector.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_sliding_card.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_underneath_buttons.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/todo_item/to_do_item_settings.dart';

class ToDoItem extends StatelessWidget {
  final ToDoModel toDo;
  final void Function() onToggleToDo;
  final void Function() onDeleteToDo;

  const ToDoItem({
    super.key,
    required this.toDo,
    required this.onToggleToDo,
    required this.onDeleteToDo,
  });

  @override
  Widget build(BuildContext context) {
    return ToDoItemGestureDetector(
      toDo: toDo,
      onToggle: onToggleToDo,
      onDelete: onDeleteToDo,
      // underneathButtons WIDGET
      underneathButtonsBuilder: (isDeletionThresholdMet, translationX) =>
          ToDoItemUnderneathButtons(
        isToDoDone: toDo.isDone,
        isDeletionThresholdMet: isDeletionThresholdMet,
        onToggleTap: onToggleToDo,
        onDeleteTap: onDeleteToDo,
        cardHeight: toDoCardHeight,
        iconButtonsWidth: iconButtonWidth,
        currentXOffset: translationX,
      ),
      // animatedToDoItem WIDGET
      animatedToDoItemBuilder: (translationX) => ToDoItemSlidingCard(
        cardHeight: toDoCardHeight,
        translationX: translationX,
        toDo: toDo,
      ),
    );
  }
}
