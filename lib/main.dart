import 'package:flutter/material.dart';
import 'package:todo_app/home_layout/home_layout.dart';
import 'package:todo_app/shared/styles/my_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: MyThemeData.darkThemeData,
      theme: MyThemeData.lightThemeData,
      themeMode: ThemeMode.light,
      initialRoute: HomeLayout.routeName,
      routes: {HomeLayout.routeName: (context) => const HomeLayout()},
      debugShowCheckedModeBanner: false,
    );
  }
}
