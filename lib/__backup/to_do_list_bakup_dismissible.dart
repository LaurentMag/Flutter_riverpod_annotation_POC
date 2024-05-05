import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/states/todo_provider.dart';
import 'package:flutter_new_riverpod_test/__backup/to_do_item_back.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoList extends ConsumerWidget {
  final List<ToDoModel> toDoList;

  const ToDoList({
    super.key,
    required this.toDoList,
  });

  /// This is the original code
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            // Each Dismissible must contain a Key. Here we are using the id of the to-do item.
            key: Key(toDoList[index].id.toString()),
            // confirmDismiss is called when the user has indicated they want to dismiss the child.
            // Here we are defining the behavior for swiping in both directions.
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                // If the user swipes the item from start to end (right), we toggle the to-do item.
                onToggle(ref, toDoList[index].id);
              } else if (direction == DismissDirection.endToStart) {
                // If the user swipes the item from end to start (left), we remove the to-do item.
                removeToDoAt(ref, toDoList[index].id);
              }
              // Returning false makes the item slide back into the list after swipe.
              return false;
            },
            // The child is the widget that we want to be dismissible. In this case, it's a to-do item.
            child: ToDoItem(
              toDo: toDoList[index],
              onToggle: () => onToggle(ref, toDoList[index].id),
              onDelete: () => removeToDoAt(ref, toDoList[index].id),
            ),
          );
        },
      ),
    );
  }
}

void removeToDoAt(WidgetRef ref, int id) {
  ref.read(toDoStateProvider.notifier).removeToDoAt(id);
}

void onToggle(WidgetRef ref, int id) {
  ref.read(toDoStateProvider.notifier).toggleToDoCheck(id);
}
