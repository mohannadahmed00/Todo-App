import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/styles/app_colors.dart';
import 'package:todo_app/providers/task_provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      builder: (context, child) {
        var provider = Provider.of<TaskProvider>(context);
        return Column(
          children: [
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime(2023, 1, 1),
              lastDate: DateTime(2023, 12, 30),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: AppColors.primaryColor,
              dayColor: AppColors.primaryColor,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: AppColors.primaryColor,
              selectableDayPredicate: (date) {
                return !provider.holidays.contains(date);
              },
              locale: 'en',
            ),
            Expanded(
                child: Center(
                    child: Text(
              "number of tasks: ${provider.tasks.length}",
              textAlign: TextAlign.center,
            )))
          ],
        );
      },
    );
  }
}
