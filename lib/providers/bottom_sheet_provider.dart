import 'package:flutter/material.dart';

class BottomSheetProvider extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
  String title = "";

  void setTitle(String text) {
    title = text;
    notifyListeners();
  }

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }
}
