import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/core/themes/ui_utils.dart';
import 'package:todo_app/modules/layouts/manager/provider/provider.dart';

class AddTaskWidget extends StatelessWidget {
  static const String routeName = "AddTaskWidget";
  const AddTaskWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, Provider, Widget? child) {
        return Container(
          padding:
              const EdgeInsets.only(right: 18, left: 18, top: 4, bottom: 4),
          child: Column(
            children: [
              Center(
                child: Text(
                  appTranslation(context).addNewTask,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: Provider.titleController,
                decoration: InputDecoration(
                    hintText: appTranslation(context).addTask,
                    labelText: appTranslation(context).addTask,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color(0xFF5D9CEC), width: 2))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: Provider.descController,
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
              const Text(
                "Selected Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                  onTap: () {
                    showTimePicker(context: context, initialTime: Provider.time)
                        .then((value) {
                      Provider.setTime(value!);
                    });
                  },
                  child: Text(
                    "${Provider.time.hour} : ${Provider.time.minute} ",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  )),
              const SizedBox(
                height: 18,
              ),
              Text(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
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
                      Provider.setDatePicker(value!);
                    });
                  },
                  child: Text(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      Provider.selectedDatePicker.toString().substring(0, 10))),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.white,
                      backgroundColor: const Color(0xFF5D9CEC).withOpacity(.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(
                            color: Color(0xFF5D9CEC),
                          ))),
                  onPressed: () {
                    Provider.addTask();
                    Navigator.pop(context);
                  },
                  child: Text(
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    appTranslation(context).addTask,
                  ))
            ],
          ),
        );
      },
    );
  }
}
