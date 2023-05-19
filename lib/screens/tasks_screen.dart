import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/widgets/task_item.dart';
import 'package:todo_app/shared/styles/app_colors.dart';
import 'package:todo_app/providers/task_provider.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

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
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Expanded(child: Center(child: CircularProgressIndicator()));
            }
            if(snapshot.hasError){
              return Expanded(child: Center(child: Text("Something went wrong",style: Theme.of(context).textTheme.bodyMedium,)));
            }
            //List<TaskModel> tasks = snapshot.data?.docs.map((e) => e.data()).toList()??[];
            provider.getTasks(snapshot);
            if(provider.tasks.isEmpty){
              return Expanded(child: Center(child: Text("No Data",style: Theme.of(context).textTheme.bodyMedium,)));
            }
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskItem(provider.tasks[index]);
              },
              itemCount: provider.tasks.length,
            ),
          );
        },)
      ],
    );
  }
}

/*FutureBuilder(
          future: FirebaseFunctions.getTasks(),
          builder: (context, snapshot) {




          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(child: Text("Something went wrong",style: Theme.of(context).textTheme.bodyMedium,));
          }
          List<TaskModel> tasks = snapshot.data?.docs.map((e) => e.data()).toList()??[];
          if(tasks.isEmpty){
            return Center(child: Text("No Data",style: Theme.of(context).textTheme.bodyMedium,));
          }
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskItem(tasks[index]);
              },
              itemCount: provider.targetTasks.length,
            ),
            /*child: ListView(
          children: [
            for (int i = 0; i < provider.tasks.length; i++) ...{
              if (provider.tasks[i].date ==
                  provider.selectedDate.toString().substring(0, 10))
                TaskItem(provider.tasks[i]),
            }
          ],*/
            /*itemBuilder: (context, index) {
          print("${provider.tasks[index].date} == ${provider.selectedDate.toString().substring(0, 10)}");
            if(provider.tasks[index].date == provider.selectedDate.toString().substring(0, 10)){
              return TaskItem(provider.tasks[index]);
            }

          },
          itemCount: provider.tasks.length,*/
          );
        },),*/
/*child: ListView(
          children: [
            for (int i = 0; i < provider.tasks.length; i++) ...{
              if (provider.tasks[i].date ==
                  provider.selectedDate.toString().substring(0, 10))
                TaskItem(provider.tasks[i]),
            }
          ],*/
/*itemBuilder: (context, index) {
          print("${provider.tasks[index].date} == ${provider.selectedDate.toString().substring(0, 10)}");
            if(provider.tasks[index].date == provider.selectedDate.toString().substring(0, 10)){
              return TaskItem(provider.tasks[index]);
            }

          },
          itemCount: provider.tasks.length,*/