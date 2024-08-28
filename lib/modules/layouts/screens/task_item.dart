import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/modules/core/themes/app_color.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      height: 115,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Slidable(
            startActionPane: ActionPane(
                extentRatio: .6,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    spacing: 8,
                    borderRadius: BorderRadius.circular(24),
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    borderRadius: BorderRadius.circular(24),
                    spacing: 8,
                    label: 'Edit',
                  ),
                ]),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 18,
                  ),
                  height: 80,
                  width: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColor.primaryColor),
                ),
                const SizedBox(
                  width: 18,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        appTranslation(context).taskTile,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      appTranslation(context).taskdes,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 88),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                      ),
                      onPressed: () {},
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 28,
                      )
                      // Image.asset(
                      //   'assets/images/icon_check.png',
                      //   color: AppColor.primaryColor,
                      // ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
