import 'package:flutter/material.dart';
import 'package:todo_app/modules/layouts/manager/provider/local_provider.dart';

class SettingLangTab extends StatelessWidget {
  const SettingLangTab({super.key});
  @override
  Widget build(BuildContext context) {
    var localeProvider = LocaleProvider.get(context);
    return Container(
      height: 350,
      decoration: BoxDecoration(
        // color: const Color(0xffB7935F).withOpacity(.1),
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: const Color.fromARGB(255, 3, 42, 94), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  localeProvider.changeLocal("en");
                },
                child: localeProvider.changeLocal == "en"
                    ? getSelectedItem(context, "English")
                    : getUnselectedItem(context, "English")),
            const SizedBox(
              height: 18,
            ),
            InkWell(
                onTap: () {
                  localeProvider.changeLocal("ar");
                },
                child: localeProvider.currentLocale == "ar"
                    ? getUnselectedItem(context, "العربية")
                    : getUnselectedItem(context, 'العربية'))
          ],
        ),
      ),
    );
  }

  Widget getSelectedItem(BuildContext context, String text) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border:
                    Border.all(color: const Color.fromARGB(255, 3, 42, 94))),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                ),
                const Icon(
                  Icons.check,
                  // color: Theme.of(context).colorScheme.secondary,
                )
              ],
            ))),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  Widget getUnselectedItem(BuildContext context, String text) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border:
                    Border.all(color: const Color.fromARGB(255, 15, 70, 138))),
            child: Center(
                child: Text(
              text,
            ))),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
