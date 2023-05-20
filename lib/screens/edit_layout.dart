import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';

import '../providers/bottom_sheet_provider.dart';
import '../providers/task_provider.dart';
import '../shared/styles/app_colors.dart';

class EditLayout extends StatelessWidget {
  static const String routeName = "EditLayout";

  bool initialDateFlag = true;

  EditLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return ChangeNotifierProvider(
      create: (context) => BottomSheetProvider(),
      builder: (context, child) {
        var provider = Provider.of<BottomSheetProvider>(context);
        var taskProvider = Provider.of<TaskProvider>(context);
        if (initialDateFlag) {
          provider
              .setInitialDate(DateTime.fromMillisecondsSinceEpoch(args.date));
          initialDateFlag = false;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          appBar: AppBar(
            title: Text(
              "ToDo App",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: Form(
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
                    initialValue: args.title,
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
                                  id: args.id,
                                  date: provider
                                      .selectedDate.millisecondsSinceEpoch,
                                  title: provider.title,
                                  status: false);
                              taskProvider.editTask(task).then((value) => Navigator.pop(context));
                            }
                          },
                          child: const Text("Edit Task")))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
