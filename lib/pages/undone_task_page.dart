import 'package:flutter/material.dart';

class UndoneTaskPage extends StatefulWidget {
  const UndoneTaskPage({Key? key}) : super(key: key);

  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('未完了タスクを表示'));
  }
}
