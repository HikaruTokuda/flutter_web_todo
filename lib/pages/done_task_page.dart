import 'package:flutter/cupertino.dart';

class DoneTaskPage extends StatefulWidget {
  const DoneTaskPage({Key? key}) : super(key: key);

  @override
  _DoneTaskPageState createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('完了タスクを表示中'));
  }
}
