import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';

class AddTaskWidget extends StatelessWidget {
  static const String routeName = "AddTaskWidget";
  AddTaskWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, Provider, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Center(
                child: Text(
                  appTranslation(context).addNewTask,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: appTranslation(context).addTask,
                    labelText: appTranslation(context).addTask,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color(0xFF5D9CEC), width: 2))),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: appTranslation(context).taskDescreption,
                    labelText: appTranslation(context).taskDescreption,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color(0xFF5D9CEC), width: 2))),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                appTranslation(context).selectedDate,
              ),
              InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: Provider.selectedDatePicker,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)))
                        .then((value) {
                      Provider!.setDatePicker(value!);
                    });
                  },
                  child: Text(
                      Provider.selectedDatePicker.toString().substring(0, 10))),
              Spacer(),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    appTranslation(context).addTask,
                  ))
            ],
          ),
        );
      },
    );
  }
}
