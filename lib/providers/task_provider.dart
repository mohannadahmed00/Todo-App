import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../shared/network/remote/firebase_functions.dart';

class TaskProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  void selectDate(DateTime date){
    selectedDate = date;
    targetTasks = tasks.where((task) => task.date == selectedDate.toString().substring(0, 10)).toList();
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
  List<TaskModel> targetTasks = [];


  void addTask(TaskModel task) {
    /*tasks.add(task);
    targetTasks = tasks.where((task) => task.date == selectedDate.toString().substring(0, 10)).toList();
    notifyListeners();*/
    FirebaseFunctions.addTask(task);
  }

  Future<QuerySnapshot<TaskModel>> getTasksSnapShot(){
    return FirebaseFunctions.getTasks(selectedDate.toString().substring(0, 10));
  }

  void getTasks(AsyncSnapshot<QuerySnapshot<TaskModel>> snapshot){
    tasks = snapshot.data?.docs.map((e) => e.data()).toList()??[];
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    if(tasks.isNotEmpty){
      tasks.remove(task);
      targetTasks = tasks.where((task) => task.date == selectedDate.toString().substring(0, 10)).toList();
      notifyListeners();
    }
  }

  void doneTask(TaskModel task) {
    /*if(tasks.isNotEmpty){
      tasks[tasks.indexOf(task)].status = true;
      notifyListeners();
    }*/
  }


}
