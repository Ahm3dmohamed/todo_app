import 'package:cloud_firestore/cloud_firestore.dart' as prefix;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/core/model/auth/pages/login_screen.dart';
import 'package:todo_app/modules/core/model/auth/pages/user_model.dart';
import 'package:todo_app/modules/core/model/task_model.dart';
import 'package:todo_app/modules/core/service/firebase_function.dart';
import 'package:todo_app/modules/layouts/screens/settings/settings.dart';
import 'package:todo_app/modules/layouts/screens/tasks/task_screen.dart';

class MainProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  DateTime selectedDatePicker = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  int currentIndex = 0;
  List<Widget> tabs = [
    const TaskScreen(),
    const Settings(),
  ];

  void setIndex(int selectedIndex) {
    currentIndex = selectedIndex;
    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    selectedDate = dateTime;
    notifyListeners();
  }

  void setTime(TimeOfDay value) {
    time = value;
    notifyListeners();
  }

  void setDatePicker(DateTime datePicker) {
    selectedDatePicker = datePicker;
    notifyListeners(); // Added notifyListeners() for UI updates
  }

  Future<void> addTask() async {
    TaskModel taskModel = TaskModel(
      desc: descController.text,
      isDone: false,
      time: "${time.hour} : ${time.minute} ",
      date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
      title: titleController.text,
    );

    try {
      await FirebaseFunction.addTask(taskModel);
      titleController.clear();
      descController.clear();
      // notifyListeners();
    } catch (error) {
      print('Failed to add task: $error');
    }
  }

  Stream<prefix.QuerySnapshot<TaskModel>> getTask() {
    return FirebaseFunction.getTask(selectedDate);
  }

  void deleteTask(String id) async {
    await FirebaseFunction.deleteTask(id);
    // notifyListeners();
  }

  void isDone(TaskModel task) async {
    try {
      await FirebaseFunction.isDoneUpdate(task);
    } catch (error) {
      print('Failed to update task status: $error');
    }
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    try {
      await FirebaseFunction.updateTask(updatedTask);
    } catch (error) {
      print('Failed to update task: $error');
    }
  }

  UserModel? user;

  MainProvider() {
    getUser();
  }

  void getUser() async {
    user = await FirebaseFunction.getUser();
    notifyListeners();
  }

  void logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }
}
