import 'package:flutter/material.dart';
import 'package:todo_app/modules/core/model/task_model.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';

class EditTaskWidget extends StatefulWidget {
  TaskModel taskModel;

  EditTaskWidget({required this.taskModel, super.key});

  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.taskModel.title);
    _descController = TextEditingController(text: widget.taskModel.desc);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Center(
        child: Text(
          "Edit Task",
        ),
      ),
      content: Container(
        height: size.height * .3,
        padding: const EdgeInsets.all(9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  label: Text(
                appTranslation(context).taskTitle,
              )),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                  label: Text(
                appTranslation(context).taskDescription,
              )),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            appTranslation(context).cancel,
          ),
        ),
        TextButton(
          onPressed: () {
            final updatedTask = TaskModel(
              date: widget.taskModel.date,
              id: widget.taskModel.id,
              title: _titleController.text,
              desc: _descController.text,
              time: widget.taskModel.time,
              isDone: widget.taskModel.isDone,
            );
            Navigator.of(context).pop(updatedTask);
          },
          child: Text(
            appTranslation(context).saveChanges,
          ),
        ),
      ],
    );
  }
}
