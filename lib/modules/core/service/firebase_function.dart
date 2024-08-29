import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/modules/core/model/task_moder.dart';

class FirebaseFunction {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<TaskModel> mainFunction() {
    return firestore.collection("Tasks").withConverter(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static addTask(TaskModel task) {
    var ref = mainFunction();
    var docRef = ref.doc();
    task.id = ref.id;
    return docRef.set(task);
  }

  static Future<QuerySnapshot<TaskModel>> getTask() {
    var ref = mainFunction();
    return ref.get();
  }
}
