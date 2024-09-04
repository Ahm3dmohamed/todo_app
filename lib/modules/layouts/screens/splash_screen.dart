import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/auth/pages/create_acount_screen.dart';
import 'package:todo_app/modules/layouts/manager/provider/theme_provider.dart';
import 'package:todo_app/modules/layouts/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LayoutScreen.routeName,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            CreateAcountScreen.routeName,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    bool isDark = provider.isDarkEnabled();
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xffDFECDB),
        ),
        child: Image.asset(isDark
            ? "assets/images/dark_splash.png"
            : "assets/images/logo.png"));
  }
}
