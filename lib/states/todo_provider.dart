import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_new_riverpod_test/data/factories/to_do_factory.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'todo_provider.g.dart';

// keepAlive: true is used to keep the state alive even if the widget is removed from the widget tree
// it disable the auto-dispose feature of the state that is by default true
@Riverpod(keepAlive: true)
class ToDoState extends _$ToDoState {
  @override
  List<ToDoModel> build() => [];

  /// Get the index of the element given item [id]
  int _getListElementIndex(int id) {
    return state.indexWhere((element) => element.id == id);
  }

  Future<void> toggleToDoCheck(int id) async {
    final index = _getListElementIndex(id);
    state = List.from(state)..[index].toggleDone();
    await _saveStateToJson();
  }

  Future<void> addToDo(String todo) async {
    state = List.from(state)..insert(0, ToDoFactory.createNewToDoModel(todo));
    await _saveStateToJson();
  }

  Future<void> removeToDoAt(int id) async {
    final index = _getListElementIndex(id);
    state = List.from(state)..removeAt(index);
    await _saveStateToJson();
  }

  /// called in [menu.dart] on app init to retrive todo from the localfile
  Future<void> retrieveToDos() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents) as List;
        state = data.map((json) => ToDoModel.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error while reading file: $e');
    }
  }

  /// Save the state to a local file
  /// called in [toggleToDoCheck], [addToDo], [removeToDoAt]
  ///
  Future<void> _saveStateToJson() async {
    final file = await _localFile;
    final json = jsonEncode(state.map((e) => e.toJson()).toList());
    await file.writeAsString(json);
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todos.json');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
