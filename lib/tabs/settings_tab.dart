import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.appearance,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: ToggleSwitch(
                  minWidth: MediaQuery.of(context).size.width * .25,
                  animate: true,
                  // with just animate set to true, default curve = Curves.easeIn
                  curve: Curves.bounceInOut,
                  // animate must be set to true when using custom curve
                  initialLabelIndex:
                      provider.themeMode == ThemeMode.light ? 1 : 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.transparent,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: const [
                    FontAwesomeIcons.lightbulb,
                    FontAwesomeIcons.solidLightbulb,
                  ],
                  iconSize: 30.0,
                  activeBgColors: const [
                    [Colors.black45, Colors.black26],
                    [Colors.yellow, Colors.orange]
                  ],
                  // animate must be set to true when using custom curve
                  onToggle: (index) {
                    if (index == 0) {
                      provider.changeThemeMode(ThemeMode.dark);
                    } else {
                      provider.changeThemeMode(ThemeMode.light);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: ToggleSwitch(
                  minWidth: MediaQuery.of(context).size.width * .25,
                  initialLabelIndex:
                      provider.locale.languageCode == "ar" ? 1 : 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.transparent,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: [
                    AppLocalizations.of(context)!.english,
                    AppLocalizations.of(context)!.arabic
                  ],
                  iconSize: 30.0,
                  activeBgColors: const [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  // animate must be set to true when using custom curve
                  onToggle: (index) {
                    if (index == 0) {
                      provider.changeLanguage('en');
                    } else {
                      provider.changeLanguage('ar');
                    }
                  },
                ),
              ),
            ],
          ),
        ),

        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context)!.language,
          ),
        ),
        GestureDetector(
          onTap: (){
            showBottomSheet(context,"language");
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.primaryColor,
              ),
            ),
            child: Text(provider.locale.languageCode=='en'?AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic),
          ),
        ),*/
      ],
    );
  }

  void showBottomSheet(BuildContext context, String type) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (context) {
          return Container(
            color: Colors.amber,
          );
          //return MyBottomSheet(type);
        });
  }
}
