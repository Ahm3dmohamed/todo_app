import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/core/service/firebase_function.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/screens/layout_screen.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSecure = true;

  void changeSecure() {
    isSecure = !isSecure;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void createAccount(BuildContext context) async {
    try {
      UserCredential? credential = await FirebaseFunction.createEmail(
        emailController.text,
        passController.text,
        phoneController.text,
        nameController.text,
      );

      if (credential?.user == null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LayoutScreen.routeName,
          (route) => false,
        );
        _showSnackBar(
          context,
          appTranslation(context).addTask,
          'Account created successfully!',
          ContentType.success,
        );
      } else {
        _showSnackBar(
          context,
          'Error!',
          'Account creation failed!',
          ContentType.failure,
        );
      }
    } catch (e) {
      _showSnackBar(
        context,
        'Error!',
        e.toString(),
        ContentType.failure,
      );
    }
  }

  void loginAccount(BuildContext context) async {
    try {
      print("Attempting login...");
      UserCredential? credential = await FirebaseFunction.loginAccount(
        emailController.text,
        passController.text,
      );

      if (credential?.user != null) {
        print("Login successful, navigating to HomeScreen...");
        Navigator.pushNamedAndRemoveUntil(
          context,
          LayoutScreen.routeName,
          (route) => false,
        );
        _showSnackBar(
          context,
          'Welcome!',
          'Welcome!',
          ContentType.success,
        );
      } else {
        print("Login failed, credentials might be incorrect.");
        _showSnackBar(
          context,
          'Error!',
          'Email or password not correct!',
          ContentType.failure,
        );
      }
    } catch (e) {
      print("Login error: $e");
      _showSnackBar(
        context,
        'Error!',
        e.toString(),
        ContentType.failure,
      );
    }
  }

  void _showSnackBar(
      BuildContext context, String title, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void resetPawword() {
    FirebaseFunction.resetPassword(passController.text);
    notifyListeners();
  }
}
