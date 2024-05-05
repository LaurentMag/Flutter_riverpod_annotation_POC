import 'dart:math';

import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';

/// generate a random id for the to-do item
int _generateRandomId() {
  return Random().nextInt(100000);
}

class ToDoFactory {
  /// Create a new [ToDoModel] with the given [todo] and a random id
  static ToDoModel createNewToDoModel(String todo) {
    return ToDoModel(
      id: _generateRandomId(),
      title: todo,
      date: DateTime.now().toUtc(),
      completedDate: null,
      isDone: false,
    );
  }
}
