import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/themes/app_color.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/theme_provider.dart';
import 'package:todo_app/modules/layouts/screens/add_task_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDarkEnabled = themeProvider.isDarkEnabled();
    return ChangeNotifierProvider(
      create: (BuildContext context) => MainProvider(),
      child: Selector<MainProvider, int>(
        selector: (p0, p1) => p1.currentIndex,
        builder: (BuildContext context, currentIndex, Widget? child) {
          var provider = Provider.of<MainProvider>(context, listen: false);
          return Scaffold(
            extendBody: true,
            floatingActionButton: FloatingActionButton(
                backgroundColor: isDarkEnabled
                    ? const Color.fromARGB(255, 4, 48, 105)
                    : AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    34,
                  ),
                  side: BorderSide(
                    color: isDarkEnabled
                        ? Colors.white.withOpacity(.6)
                        : AppColor.primaryColor,
                    width: 3,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    context: context,
                    builder: (context) {
                      return ChangeNotifierProvider.value(
                          value: provider, child: const AddTaskWidget());
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 34,
                  color: Colors.white,
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              height: 72,
              color: AppColor.secondaryColor,
              padding: EdgeInsets.zero,
              notchMargin: 14,
              shape: const CircularNotchedRectangle(),
              child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: provider.setIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: const ImageIcon(
                      AssetImage('assets/images/icon_list.png'),
                      size: 34,
                    ),
                    label: appTranslation(context).list,
                  ),
                  BottomNavigationBarItem(
                    icon: const ImageIcon(
                      AssetImage(
                        'assets/images/icon_settings.png',
                      ),
                      size: 34,
                    ),
                    label: appTranslation(context).language,
                  ),
                ],
              ),
            ),
            body: provider.tabs[currentIndex],
          );
        },
      ),
    );
  }
}
