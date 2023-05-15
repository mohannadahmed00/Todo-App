import '../shared/components/constants.dart';

class TaskModel {
  String id, date, title;
  TaskStatus status;

  TaskModel(
      {this.id = "",
      required this.date,
      required this.title,
      required this.status});

  TaskModel.fromJSON(Map<String, dynamic> json)
      : this(
          id: json['id'],
          date: json['date'],
          title: json['title'],
          status: json['status'],
        );

  Map<String, dynamic> toJSON(TaskModel task) {
    return {
      "id": id,
      "date": date,
      "title": title,
      "status": status,
    };
  }
}
