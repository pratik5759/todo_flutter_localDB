
class TodoModel {

  String task;
  String desc;
  bool isCompleted;
  int createdAt;
  int completedAt;

  TodoModel({
    required this.task,
    required this.desc,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt = 0
});
}