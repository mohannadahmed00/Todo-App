import 'package:intl/intl.dart';

class TaskModel {
  static const String COLLECTION_NAME = "Tasks";
  String id, title;
  int date;
  bool status;

  TaskModel(
      {this.id = "",
      required this.date,
      required this.title,
      required this.status});

  TaskModel.fromJSON(Map<String, dynamic> json)
      : this(
          //id: json['id'],
          date: json['date'],
          title: json['title'],
          status: json['status'],
        );

  Map<String, dynamic> toJSON() {
    return {
      //"id": id,
      "date": date,
      "title": title,
      "status": status,
    };
  }

  String getDate(){
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(datetime);
    return formattedDate;
  }
}
