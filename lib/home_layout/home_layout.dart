import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/home_provider.dart';
import 'package:todo_app/screens/widgets/task_bottom_sheet.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "HomeLayout";

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var provider = Provider.of<HomeProvider>(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              "ToDo App",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_outlined), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
              ],
              currentIndex: provider.index,
              iconSize: 30,
              onTap: (selectedIndex) {
                provider.selectTap(selectedIndex);
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAddTaskBottomSheet(context);
            },
            shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 3),
            ),
            child: const Icon(Icons.add),
          ),
          body: provider.tabs[provider.index],
        );
      },
    );
  }

  void showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const TaskBottomSheet(),
            ));
  }
}
