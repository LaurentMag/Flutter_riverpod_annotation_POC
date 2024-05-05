import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item_gesture_detector.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item_top_animated.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item_underneath_buttons.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';

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
        cardHeight: TodoSettings.toDoCardHeight,
        iconButtonsWidth: TodoSettings.iconButtonWidth,
        translationX: translationX,
      ),
      // animatedToDoItem WIDGET
      animatedToDoItemBuilder: (translationX) => ToDoItemTopAnimated(
        cardHeight: TodoSettings.toDoCardHeight,
        translationX: translationX,
        toDo: toDo,
      ),
    );
  }
}
