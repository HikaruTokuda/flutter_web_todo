import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class AddTaskPage extends StatefulWidget {

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();

  Future<void> insertTask(String title) async {
    var collection = FirebaseFirestore.instance.collection('task');
    collection.add({
      'title': title,
      'is_done': false,
      'created_time': Timestamp.now()
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taskを追加'),
      ),
      body: Center(       // body内
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('タイトル'),
            ),
            Container(
              width: 588,
                child: TextField(
                  controller: titleController,      // テキストフィールドに入力された文字がここに入る
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                width: 250,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      await insertTask(titleController.text);
                      Navigator.pop(context);
                    },
                    child: Text('追加')
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
