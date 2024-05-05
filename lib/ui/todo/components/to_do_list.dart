import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/states/todo_provider.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoList extends ConsumerWidget {
  final List<ToDoModel> toDoList;

  const ToDoList({
    super.key,
    required this.toDoList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(toDoStateProvider.notifier).retrieveToDos();

    return Expanded(
      child: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ToDoItem(
              toDo: toDoList[index],
              onToggleToDo: () => onToggle(ref, toDoList[index].id),
              onDeleteToDo: () => removeToDoAt(ref, toDoList[index].id),
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
