import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/model/task_model.dart';
import 'package:todo_app/modules/core/themes/app_color.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';
import 'package:todo_app/modules/layouts/manager/provider/theme_provider.dart';
import 'package:todo_app/modules/layouts/screens/tasks/edit_taskwidget.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDarkEnabled = themeProvider.isDarkEnabled();

    return Consumer<MainProvider>(
      builder: (BuildContext context, mainProvider, Widget? child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF0392CF),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          height: 115,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.6,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    mainProvider.deleteTask(taskModel.id);
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  icon: Icons.delete,
                  label: appTranslation(context).delete,
                ),
                SlidableAction(
                  onPressed: (context) async {
                    final updatedTask = await showDialog<TaskModel>(
                      context: context,
                      builder: (context) =>
                          EditTaskWidget(taskModel: taskModel),
                    );
                    if (updatedTask != null) {
                      mainProvider.updateTask(updatedTask);
                    }
                  },
                  backgroundColor: const Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  borderRadius: BorderRadius.circular(24),
                  label: appTranslation(context).edit,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkEnabled ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Container(
                    height: 80,
                    width: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: taskModel.isDone
                          ? Colors.green
                          : AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          taskModel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: taskModel.isDone
                                ? Colors.green
                                : AppColor.primaryColor,
                          ),
                        ),
                        Text(
                          taskModel.desc,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                taskModel.isDone ? Colors.green : Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.timelapse),
                            const SizedBox(width: 5),
                            Text(
                              taskModel.time,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      mainProvider.isDone(taskModel);
                    },
                    child: taskModel.isDone
                        ? Text(
                            appTranslation(context).isDone,
                            style: const TextStyle(color: Colors.green),
                          )
                        : Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.primaryColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 5)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
