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
        toolbarHeight: 200,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34)),
        ),
        title: Text(
          appTranslation(context).setting,
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
            Text(
              textAlign: TextAlign.start,
              appTranslation(context).mode,
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color.fromARGB(255, 3, 42, 94))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      themeProvider.currentTheme.name,
                      style: const TextStyle(color: Color(0xFF5D9CEC)),
                    ),
                    IconButton(
                        onPressed: () {
                          showThemeBottomSheet(context);
                        },
                        icon: const Icon(Icons.arrow_drop_down_outlined))
                  ],
                )),
            const SizedBox(
              height: 18,
            ),
            Text(
              appTranslation(context).language,
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color.fromARGB(255, 3, 42, 94))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Color(0xFF5D9CEC)),
                      localeProvider.getCurrentLocale(),
                    ),
                    IconButton(
                        onPressed: () {
                          showlanguageBottomSheet(context);
                        },
                        icon: const Icon(Icons.arrow_drop_down_outlined))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const SettingThemeTab();
        });
  }
}

void showlanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const SettingLangTab();
      });
}
