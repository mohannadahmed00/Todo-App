import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/tabs/widgets/task_item.dart';
import 'package:todo_app/shared/styles/app_colors.dart';
import 'package:todo_app/providers/task_provider.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectedDate,
          firstDate: DateTime(2023, 1, 1),
          lastDate: DateTime(2023, 12, 30),
          onDateSelected: (date) {
            provider.selectDate(date);
          },
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
        StreamBuilder(
          stream: provider.getTasksSnapShot(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError) {
              return Expanded(
                  child: Center(
                      child: Text(
                "Something went wrong",
                style: Theme.of(context).textTheme.bodyMedium,
              )));
            }
            provider.getTasks(snapshot);
            if (provider.tasks.isEmpty) {
              return Expanded(
                  child: Center(
                      child: Text(
                "No Data",
                style: Theme.of(context).textTheme.bodyMedium,
              )));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(provider.tasks[index]);
                },
                itemCount: provider.tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
