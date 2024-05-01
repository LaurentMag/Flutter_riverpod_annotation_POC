import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

@riverpod
class ToDoState extends _$ToDoState {
  @override
  List<String> build() => [];

  void addToDo(String todo) {
    state = [...state, todo];
  }
}
