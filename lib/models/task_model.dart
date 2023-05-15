import '../shared/components/constants.dart';

class TaskModel {
  String id, date, title;
  TaskStatus status;

  TaskModel(
      {this.id = "",
      required this.date,
      required this.title,
      required this.status});
}
