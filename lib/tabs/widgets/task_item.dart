import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/edit_layout.dart';
import 'package:todo_app/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<TaskProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Builder(
                builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(color:task.status? AppColors.redColor:AppColors.primaryColor),
                    )),
          ),
          Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              //dismissible: DismissiblePane(onDismissed: () {print("dismiss");}),

              children: [
                SlidableAction(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  onPressed: (context) {
                    provider.removeTask(task.id);
                  },
                  backgroundColor: AppColors.redColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                if(!task.status)SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(context, EditLayout.routeName,arguments: task);
                  },
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 2.0,
                      color: task.status
                          ? AppColors.greenColor
                          : AppColors.primaryColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: task.status
                                          ? AppColors.greenColor
                                          : AppColors.primaryColor),
                            ),
                            Text(
                              task.getDate(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.doneTask(task);
                      },
                      child: task.status
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * .25,
                              child: Text(
                                "Done!",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.greenColor),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * .25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.primaryColor),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
