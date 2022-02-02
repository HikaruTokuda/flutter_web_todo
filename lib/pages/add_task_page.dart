import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
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
