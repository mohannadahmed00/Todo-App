import 'package:flutter/material.dart';
import '../shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginLayout extends StatelessWidget {
  static const String routeName = "AuthLayout";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          //key: sheetProvider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 50),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        //final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false, unicode: true, dotAll: true,);
                      },
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        //final RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', caseSensitive: true, unicode: true, dotAll: true,);
                      },
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.password),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: ElevatedButton(
                            onPressed: () {
                              /*if (sheetProvider.formKey.currentState!.validate()) {
                            if (task != null) {
                              TaskModel task = TaskModel(
                                  id: this.task!.id,
                                  date: sheetProvider
                                      .selectedDate.millisecondsSinceEpoch,
                                  title: sheetProvider.title,
                                  status: false);
                              taskProvider
                                  .editTask(task)
                                  .then((value) => Navigator.pop(context));
                            } else {
                              TaskModel task = TaskModel(
                                  date: sheetProvider
                                      .selectedDate.millisecondsSinceEpoch,
                                  title: sheetProvider.title,
                                  status: false);
                              taskProvider.addTask(task);
                            }
                          }*/
                            },
                            child: Text(AppLocalizations.of(context)!.login))),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    "Create Account",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
