import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import '../../providers/bottom_sheet_provider.dart';
import '../../shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskBottomSheet extends StatelessWidget {
  const TaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomSheetProvider(),
      builder: (context, child) {
        var mainProvider = Provider.of<MainProvider>(context);
        var sheetProvider = Provider.of<BottomSheetProvider>(context);
        var taskProvider = Provider.of<TaskProvider>(context);
        return Form(
          key: sheetProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.add_new_task,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: mainProvider.themeMode == ThemeMode.light?AppColors.black:AppColors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.add_new_task;
                    }
                    sheetProvider.title = text;
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.task_title),
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
                    AppLocalizations.of(context)!.select_date,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: mainProvider.themeMode == ThemeMode.light?AppColors.black:AppColors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    sheetProvider.selectDate(context);
                  },
                  child: Text(
                    sheetProvider.selectedDate.toString().substring(0, 10),
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
                          if (sheetProvider.formKey.currentState!.validate()) {
                            TaskModel task = TaskModel(
                                date: sheetProvider.selectedDate.millisecondsSinceEpoch,
                                title: sheetProvider.title,
                                status: false);
                            taskProvider.addTask(task);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.add)))
              ],
            ),
          ),
        );
      },
    );
  }
}
