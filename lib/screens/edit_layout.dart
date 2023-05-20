import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/main_provider.dart';
import '../providers/bottom_sheet_provider.dart';
import '../providers/task_provider.dart';
import '../shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        var mainProvider = Provider.of<MainProvider>(context);
        var sheetProvider = Provider.of<BottomSheetProvider>(context);
        var taskProvider = Provider.of<TaskProvider>(context);
        if (initialDateFlag) {
          sheetProvider
              .setInitialDate(DateTime.fromMillisecondsSinceEpoch(args.date));
          initialDateFlag = false;
        }
        return Scaffold(
          backgroundColor: mainProvider.themeMode == ThemeMode.light?AppColors.white:AppColors.black,
          extendBody: true,
          appBar: AppBar(
            title: Text(
              "ToDo App",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: Form(
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
                    initialValue: args.title,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.task_validation;
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
                                  id: args.id,
                                  date: sheetProvider
                                      .selectedDate.millisecondsSinceEpoch,
                                  title: sheetProvider.title,
                                  status: false);
                              taskProvider.editTask(task).then((value) => Navigator.pop(context));
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.edit)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
