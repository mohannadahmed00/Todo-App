import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
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
        //clipBehavior: Clip.antiAlias,
        children: [
          /*Container(
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 4),
            color: Color(0xFFFE4A49),
          ),*/
          Positioned.fill(
            child: Builder(
                builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(color: AppColors.redColor),
                    )),
          ),
          Slidable(
            // Specify a key if the Slidable is dismissible.
            //key: const ValueKey(0),

            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
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
                    provider.removeTask(task);
                  },
                  backgroundColor: AppColors.redColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              //margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 2.0,
                      // set the height to fill the available space
                      color: task.status
                          ? AppColors.greenColor
                          :AppColors.primaryColor ,
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
                                          :AppColors.primaryColor ),
                            ),
                            Text(
                              task.date,
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: task.status
                                ? AppColors.greenColor
                                : AppColors.primaryColor),
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
