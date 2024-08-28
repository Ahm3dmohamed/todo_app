import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocaleProvider extends ChangeNotifier {
  String currentLocale = "en";

  void changeLocal(String newLocale) {
    currentLocale = newLocale;
    notifyListeners();
  }

  getCurrentLocale() {
    return currentLocale == "en" ? "English" : "العربية";
  }

  static LocaleProvider get(BuildContext context) {
    return Provider.of<LocaleProvider>(context);
  }
}
