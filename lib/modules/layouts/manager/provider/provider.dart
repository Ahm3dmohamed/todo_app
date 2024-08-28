import 'package:flutter/material.dart';
import 'package:todo_app/modules/layouts/screens/settings/settings.dart';
import 'package:todo_app/modules/layouts/screens/task_screen.dart';

class MainProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  DateTime selectedDatePicker = DateTime.now();

  int currentIndex = 0;
  List<Widget> tabs = [
    TaskScreen(),
    Settings(),
  ];
  void setIndex(selectedIndex) {
    currentIndex = selectedIndex;
    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    selectedDate = dateTime;
    notifyListeners();
  }

  void setDatePicker(DateTime datePicker) {
    selectedDatePicker = datePicker;
  }
}
