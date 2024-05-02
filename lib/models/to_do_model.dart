class ToDoModel {
  int id;
  String title;
  DateTime? date;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.title,
    required this.date,
    required this.isDone,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
