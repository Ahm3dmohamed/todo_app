import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';
import 'package:todo_app/modules/layouts/screens/add_task_widget.dart';
import 'package:todo_app/modules/layouts/screens/task_item.dart';

class TaskScreen extends StatelessWidget {
  static const String routeName = "TaskScreen";
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, Provider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 140,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(34)),
              side: BorderSide(color: Colors.black),
            ),
            title: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                appTranslation(context).language,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ),
          body: Column(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    context: context,
                    builder: (context) {
                      return ChangeNotifierProvider.value(
                          value: Provider, child: AddTaskWidget());
                    },
                  );
                },
                child: EasyInfiniteDateTimeLine(
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  focusDate: Provider.selectedDate,
                  showTimelineHeader: false,
                  onDateChange: Provider.setDate,
                  activeColor: const Color(0xff37306B),
                  dayProps: const EasyDayProps(
                    activeDayStyle: DayStyle(
                      borderRadius: 34.0,
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(),
                      borderRadius: 32.0,
                    ),
                  ),
                  timeLineProps: const EasyTimeLineProps(
                    hPadding: 16.0, // padding from left and right
                    separatorPadding: 16.0, // padding between days
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return TaskItem();
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 12,
                      );
                    },
                    itemCount: 30),
              )
            ],
          ),
        );
      },
    );
  }
}
