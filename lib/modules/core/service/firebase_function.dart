import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/core/model/auth/pages/user_model.dart';
import 'package:todo_app/modules/core/model/task_model.dart';

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

  static CollectionReference<UserModel> mainUserFunction() {
    return firestore.collection("Users").withConverter(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) async {
    var ref = mainFunction();
    var docRef = ref.doc(); // Create a new document reference
    task.id = docRef.id; // Assign the document ID to task.id
    task.userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    await docRef.set(task);
  }

  static Future<void> addUser(UserModel user) async {
    var ref = mainUserFunction();
    await ref.doc(user.userId).set(user);
  }

  static Future<UserModel?> getUser() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (userId.isEmpty) return null;

    var ref = mainUserFunction();
    var docRef = await ref.doc(userId).get();

    if (docRef.exists) {
      return docRef.data(); // Return the user data
    }
    return null;
  }

  static Future<void> isDoneUpdate(TaskModel task) async {
    var ref = mainFunction();
    var docRef = ref.doc(task.id);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      task.isDone = !task.isDone;
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

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      await docRef.delete();
    } else {
      print('Document not found.');
    }
  }

  static Future<UserCredential?> createEmail(
      String email, String password, String phone, String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();

      UserModel newUser = UserModel(
        userId: credential.user!.uid,
        userEmail: email,
        userName: name,
        userPhone: phone,
        userPassword: password,
      );
      await addUser(newUser);

      return credential;
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    } catch (e) {
      print("Error: ${e.toString()}");
    }
    return null;
  }

  static Future<UserCredential?> loginAccount(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
      // if (credential.user != null) {
      //   if (!credential.user!.emailVerified) {
      //     print("Error: Email is not verified.");
      //     return null;
      //   }
      //   return credential;
      // }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message ?? "An error occurred"}");
    }
    return null;
  }

  static Future<void> updateTask(TaskModel updatedTask) async {
    var ref = mainFunction();
    var docRef = ref.doc(updatedTask.id);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      await docRef.update(updatedTask.toJson());
    } else {
      print('Document not found.');
    }
  }

  static resetPassword(String email) {
    final credential = FirebaseAuth.instance.sendPasswordResetEmail(
        email: email, actionCodeSettings: ActionCodeSettings(url: email));
    return credential;
  }
}
