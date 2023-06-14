import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_with_getx/Model/Task.dart';

class FireStore {
  static Future<void> addTask(Task task) async {
    await FirebaseFirestore.instance
        .collection('Tasks')
        .add({
          'task_Name': task.taskName,
          'task_Date': task.taskTime,
          'isCompleted': task.isCompleted,
        })
        .then((value) => print("Task Added"))
        .catchError((error) => print("Failed to add task: $error"));
  }

  static Future<void> editIsCompleted(bool isCompleted, String id) async {
    await FirebaseFirestore.instance
        .collection('Tasks')
        .doc(id)
        .update({
      'isCompleted': isCompleted,
    })
        .then((value) => print("Task Updated"))
        .catchError((error) => print("Failed to updated task: $error"));
  }
  static Future<void> deleteTask({required String id}) async {
    await FirebaseFirestore.instance
        .collection('Tasks')
        .doc(id)
        .delete()
        .then((value) => print("Task Deleted"))
        .catchError((error) => print("Failed to delete task: $error"));
  }
}
