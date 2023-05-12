import 'package:flutter/material.dart';
import 'package:todo_app/screens/settings_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';

class HomeProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> tabs = [const TasksScreen(), const SettingsScreen()];

  void selectTap(int tabIndex) {
    index = tabIndex;
    notifyListeners();
  }
}
