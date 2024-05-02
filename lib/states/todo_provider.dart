import 'dart:math';

import 'package:flutter_new_riverpod_test/models/to_do_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

// keepAlive: true is used to keep the state alive even if the widget is removed from the widget tree
// it disable the auto-dispose feature of the state that is by default true
@Riverpod(keepAlive: true)
class ToDoState extends _$ToDoState {
  @override
  List<ToDoModel> build() => [];

  void toggleToDoCheck(int id) {
    final index = getListElementIndex(id);
    state = List.from(state)..[index].toggleDone();
  }

  void addToDo(String todo) {
    state = List.from(state)..add(createNewToDoModel(todo));
  }

  void removeToDoAt(int id) {
    final index = getListElementIndex(id);
    state = List.from(state)..removeAt(index);
  }

  /// generate a random id for the to-do item
  int generateRandomId() {
    return Random().nextInt(100000);
  }

  /// Create a new [ToDoModel] with the given [todo] and a random id
  ToDoModel createNewToDoModel(String todo) {
    return ToDoModel(
      id: generateRandomId(),
      title: todo,
      date: DateTime.now().toUtc(),
      isDone: false,
    );
  }

  /// Get the index of the element with the given [id]
  int getListElementIndex(int id) {
    return state.indexWhere((element) => element.id == id);
  }
}
