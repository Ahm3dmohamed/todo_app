import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  static Future<void> addTask(TaskModel task) async {
    var ref = mainFunction();
    var docRef = ref.doc(); // Create a new document reference
    task.id = docRef.id; // Correctly assign the document ID to task.id
    await docRef.set(task);
  }

  static Future<void> isDoneUpdate(TaskModel task) async {
    var ref = mainFunction();
    var docRef = ref.doc(task.id);

    // Check if the document exists before updating
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      task.isDone = !task.isDone; // Toggle the isDone status
      await docRef.update(task.toJson());
    } else {
      print('Document not found.');
    }
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime time) {
    var ref = mainFunction();
    return ref
        .where("date",
            isEqualTo: DateUtils.dateOnly(time).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) async {
    var ref = mainFunction();
    var docRef = ref.doc(id);

    // Check if the document exists before deleting
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      await docRef.delete();
    } else {
      print('Document not found.');
    }
  }

  static Future<void> createEmail(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
