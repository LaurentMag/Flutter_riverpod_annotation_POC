import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/states/todo_provider.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/text_field_todo.dart';

import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ToDoModel> toDoList = ref.watch(toDoStateProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFieldTodo(
                label: 'To Do creation',
                onTextFieldSubmitted: (String value) => addToDo(ref, value),
              ),
              ToDoList(toDoList: toDoList),
            ],
          ),
        ),
      ),
    );
  }
}

void addToDo(WidgetRef ref, String value) {
  if (value.isEmpty) return;
  ref.read(toDoStateProvider.notifier).addToDo(value);
}
