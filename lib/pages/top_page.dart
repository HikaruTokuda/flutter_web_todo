import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class TopPage extends StatefulWidget {
  TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Task> taskList = [
    Task(title: "宿題",
        isDone: false,
        createdTime: DateTime.now()
    ),
    Task(title: "買い出し",
        isDone: false,
        createdTime: DateTime.now()
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Firebase * Flutter for Web'),
      ),
      body: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              title: Text(taskList[index].title!),
              value: taskList[index].isDone,
              onChanged: (bool? value) {
                taskList[index].isDone = !taskList[index].isDone!;
                taskList.removeAt(index);
                setState(() {});
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}