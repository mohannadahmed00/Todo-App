import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/shared/components/constants.dart';
import '../../providers/bottom_sheet_provider.dart';
import '../../shared/styles/app_colors.dart';

class TaskBottomSheet extends StatelessWidget {
  const TaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomSheetProvider(),
      builder: (context, child) {
        var provider = Provider.of<BottomSheetProvider>(context);
        var taskProvider = Provider.of<TaskProvider>(context);
        return Form(
          key: provider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Task",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter task title";
                    }
                    provider.title = text;
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Task Title"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Select Date",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.selectDate(context);
                  },
                  child: Text(
                    provider.selectedDate.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: ElevatedButton(
                        onPressed: () {
                          if (provider.formKey.currentState!.validate()) {
                            TaskModel task = TaskModel(
                                date: provider.selectedDate
                                    .toString()
                                    .substring(0, 10),
                                title: provider.title,
                                status: TaskStatus.pending);
                            taskProvider.addTask(task);
                            print(
                                "valid: ${provider.selectedDate.toString().substring(0, 10)} => ${provider.title}");
                          } else {
                            print("invalid");
                          }
                        },
                        child: const Text("Add Task")))
              ],
            ),
          ),
        );
      },
    );
  }
}
