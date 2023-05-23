import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/login_provider.dart';
import '../shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginLayout extends StatelessWidget {
  static const String routeName = "AuthLayout";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>LoginProvider(),
      builder: (context,child){
        var loginProvider = Provider.of<LoginProvider>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: loginProvider.formKey,
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
                            final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com+");
                            if(value!.isEmpty){
                              return "please enter your mail";
                            }
                            if(!emailRegExp.hasMatch(value)){
                              return "please enter valid mail";
                            }
                            return null;
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
                          obscureText: true,
                          validator: (value) {

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
                                  if (loginProvider.formKey.currentState!.validate()) {
                                    print("valid");
                                  }else{
                                    print("invalid");
                                  }
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
      },
    );
  }
}
