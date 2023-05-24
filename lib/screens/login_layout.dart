import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/login_provider.dart';
import 'package:todo_app/screens/home_layout.dart';
import 'package:todo_app/screens/sign_up_layout.dart';
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
                              return AppLocalizations.of(context)!.enter_mail;
                            }
                            if(!emailRegExp.hasMatch(value)){
                              return AppLocalizations.of(context)!.enter_valid_mail;
                            }
                            loginProvider.setEmail(value);
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
                            if(value!.isEmpty){
                              return AppLocalizations.of(context)!.enter_pass;
                            }
                            loginProvider.setPassword(value);
                            return null;
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
                                    loginProvider.login(onSuccess: (){
                                      Navigator.pushNamed(context, HomeLayout.routeName);
                                    });
                                    /*if(loginProvider.responseCode == "200"){
                                      Navigator.pushNamed(context, HomeLayout.routeName);
                                    }*/
                                    print("valid");
                                  }else{
                                    print("invalid");
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!.login))),
                        Text(loginProvider.responseCode!="200" && loginProvider.responseCode.isNotEmpty?"*${loginProvider.responseCode.replaceAll("-", " ")}":"",style: TextStyle(color: Colors.red,fontSize: 12),)

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.do_not_have_acc,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignUpLayout.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_acc,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ),
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
