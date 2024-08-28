import 'package:flutter/material.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/local_provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/theme_provider.dart';
import 'package:todo_app/modules/layouts/screens/settings/setting_lang_tab.dart';
import 'package:todo_app/modules/layouts/screens/settings/setting_theme_tab.dart';

class Settings extends StatelessWidget {
  static const String routeName = "Settings";
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var localeProvider = LocaleProvider.get(context);
    ThemeProvider themeProvider = ThemeProvider.get(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34)),
          side: BorderSide(color: Colors.black),
        ),
        title: Text(
          appTranslation(context).language,
          textDirection: TextDirection.ltr,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text(appTranslation(context).mode),
            const SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet(context);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xffB7935F))),
                  child: Center(
                      child: Text(
                    themeProvider.currentTheme.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(
                            0xFF141922,
                          ),
                        ),
                  ))),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              appTranslation(context).language,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: () {
                showlanguageBottomSheet(context);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xffB7935F))),
                  child: Center(
                      child: Text(
                    localeProvider.getCurrentLocale(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(
                            0xffB7935F,
                          ),
                        ),
                  ))),
            ),
          ],
        ),
      ),
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SettingThemeTab();
        });
  }
}

void showlanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SettingLangTab();
      });
}
