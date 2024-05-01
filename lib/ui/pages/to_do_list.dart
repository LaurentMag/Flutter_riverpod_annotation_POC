import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/states/todo_provider.dart';
import 'package:flutter_new_riverpod_test/ui/components/app_bar_go_back.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoList extends ConsumerWidget {
  ToDoList({super.key});

  final TextEditingController _todoTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> toDoList = ref.watch(toDoStateProvider);

    print('ToDoList: toDoList: $toDoList');

    return Scaffold(
      appBar: const AppBarGoBack(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _todoTextFieldController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New To Do',
                      ),
                      onSubmitted: (String value) {
                        // ignore: avoid_print
                        addToDo(
                          ref,
                          value,
                          _todoTextFieldController,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: toDoList
                  .map((String toDo) => ListTile(
                        title: Text(toDo),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

void addToDo(WidgetRef ref, String value, TextEditingController controller) {
  ref.read(toDoStateProvider.notifier).addToDo(value);
  controller.clear();
}
