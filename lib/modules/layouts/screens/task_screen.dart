import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/task_moder.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/theme_provider.dart';
import 'package:todo_app/modules/layouts/screens/add_task_widget.dart';
import 'package:todo_app/modules/layouts/screens/task_item.dart';

class TaskScreen extends StatelessWidget {
  static const String routeName = "TaskScreen";
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDarkEnabled = themeProvider.isDarkEnabled();

    return Consumer<MainProvider>(
      builder: (BuildContext context, Provider, Widget? child) {
        return Scaffold(
          body: Stack(
            children: [
              // AppBar positioned at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  toolbarHeight: 200,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34),
                      bottomRight: Radius.circular(34),
                    ),
                  ),
                  title: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 44),
                    child: Text(
                      appTranslation(context).appTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 220),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    GestureDetector(
                      onDoubleTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider.value(
                              value: Provider,
                              child: const AddTaskWidget(),
                            );
                          },
                        );
                      },
                      child: Align(
                        heightFactor: .01,
                        alignment: const Alignment(0, 0),
                        child: EasyInfiniteDateTimeLine(
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          focusDate: Provider.selectedDate,
                          showTimelineHeader: false,
                          onDateChange: Provider.setDate,
                          activeColor: const Color(0xff37306B),
                          dayProps: EasyDayProps(
                            todayHighlightStyle:
                                TodayHighlightStyle.withBackground,
                            todayHighlightColor:
                                const Color.fromARGB(255, 206, 198, 198),
                            activeDayNumStyle: TextStyle(
                              color:
                                  isDarkEnabled ? Colors.black : Colors.white,
                            ),
                            inactiveDayNumStyle: TextStyle(
                              color:
                                  isDarkEnabled ? Colors.white : Colors.black,
                            ),
                          ),
                          timeLineProps: const EasyTimeLineProps(
                            hPadding: 16.0,
                            separatorPadding: 16.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 55),
                    Expanded(
                      child: StreamBuilder(
                        stream: Provider.getTask(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(child: Text("Error Data"));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text(" "));
                          } else {
                            List<TaskModel> tasks = snapshot.data!.docs
                                .map((e) => e.data())
                                .toList();
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return TaskItem(
                                  taskModel: tasks[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 12,
                                );
                              },
                              itemCount: tasks.length,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
