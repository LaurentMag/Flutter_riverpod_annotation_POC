import 'package:json_annotation/json_annotation.dart';

part 'to_do_model.g.dart';

@JsonSerializable()
class ToDoModel {
  int id;
  String title;
  DateTime? date;
  DateTime? completedDate;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.title,
    required this.date,
    required this.completedDate,
    required this.isDone,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ToDoModelToJson(this);

  void toggleDone() {
    isDone = !isDone;
    _setCompletedDate();
  }

  void _setCompletedDate() {
    if (isDone) {
      completedDate = DateTime.now().toUtc();
    } else {
      if (completedDate != null) {
        completedDate = null;
      }
    }
  }
}
