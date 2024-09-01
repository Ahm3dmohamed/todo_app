import 'package:flutter/material.dart';
import 'package:todo_app/modules/core/service/firebase_function.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController PhonePassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSecure = true;

  void changeSecure() {
    isSecure = !isSecure;
    notifyListeners();
  }

  void createAccount() {
    FirebaseFunction.createEmail(emailController.text, passController.text);
    notifyListeners();
  }
}
