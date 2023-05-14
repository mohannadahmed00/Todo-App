import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  void selectDate(DateTime date){
    selectedDate = date;
    notifyListeners();
  }

  List<DateTime> holidays = [
    DateTime(2023, 1, 2),
    DateTime(2023, 6, 1),
    DateTime(2023, 9, 25),
    DateTime(2023, 10, 6),
    DateTime(2023, 10, 23)
  ];

  List<TaskModel> tasks = [];

  void addTask(TaskModel task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    if(tasks.isNotEmpty){
      tasks.remove(task);
      notifyListeners();
    }
  }

  void doneTask(TaskModel task) {
    if(tasks.isNotEmpty){
      tasks[tasks.indexOf(task)].status = "done";
      notifyListeners();
    }
  }


}
