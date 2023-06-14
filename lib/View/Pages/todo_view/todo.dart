import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:todo_app_with_getx/Controller/firebae_firestore_controller.dart';
import 'package:todo_app_with_getx/Controller/firebase_auth_controller.dart';
import 'package:todo_app_with_getx/Model/Task.dart';

class ToDoPage extends StatelessWidget {
  ToDoPage({Key? key}) : super(key: key);
  var firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final _taskController = TextEditingController();
  final Stream<QuerySnapshot> _todoStream = FirebaseFirestore.instance
      .collection('Tasks')
      .orderBy('task_Date', descending: true)
      .snapshots();

  signOutFunction() async {
    await FireAuth.signOut();
  }

  addTaskFunction(Task task) async {
    await FireStore.addTask(task);
  }

  addTaskWidget(BuildContext context) {
    Dialogs.materialDialog(
        title: "Add Task",
        color: Colors.white,
        context: context,
        dialogWidth: kIsWeb ? 0.3 : null,
        onClose: (value) => print("returned value is '$value'"),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        customView: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _taskController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 8, color: Colors.orangeAccent),
                  ),
                  labelText: 'Task info',
                ),
              ),
            )
          ],
        ),
        actions: [
          IconsOutlineButton(
            onPressed: () {
              _taskController.text = '';
              Navigator.of(context).pop(['Test', 'List']);
            },
            text: 'Cancel',
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsOutlineButton(
            onPressed: () {
              if (_taskController.text.trim() != '' &&
                  _taskController.text.isNotEmpty) {
                print(_taskController.text);
                var task = Task(_taskController.text.trim());
                addTaskFunction(task);
                _taskController.text = '';
                Navigator.of(context).pop(['Test', 'List']);
              }
            },
            text: "Add",
            iconData: Icons.add,
            color: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'ToDo',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {
                signOutFunction();
                Get.back();
              },
              icon: const Icon(Icons.logout))
        ],
        leading: Text(''),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          addTaskWidget(context);
          print(_taskController.value);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: _todoStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return customTask(
                        taskName: data['task_Name'],
                        isCompleted: data['isCompleted'],
                        context: context, id: document.id);
                  }).toList(),
                );
              },
            ))
          ],
        ),
      ),
    ));
  }
}

Widget customTask({
  required String taskName,
  required bool isCompleted,
  required String id,
  required BuildContext context,
}) {
  var size = MediaQuery.of(context).size;
  bool isChecked = isCompleted;
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.orange[100], borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: MSHCheckbox(
                size: 15,
                value: isChecked,
                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                  checkedColor: Colors.blue,
                ),
                style: MSHCheckboxStyle.stroke,
                onChanged: (selected) async{
                  isChecked = selected;
                  await FireStore.editIsCompleted(isChecked, id);
                  // print(id);
                  // print(selected);
                },
              ),
            ),
            Expanded(
              child: Container(
                width: size.width * 0.6,
                padding: const EdgeInsets.all(5),
                child: Text(
                  taskName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: isChecked? TextDecoration.lineThrough: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 1),
              child: IconButton(
                // color: Colors.black,
                onPressed: () async{
                  await FireStore.deleteTask(id: id);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
