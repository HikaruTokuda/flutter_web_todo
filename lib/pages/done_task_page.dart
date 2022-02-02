import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class DoneTaskPage extends StatefulWidget {
  final List<Task>? undoneTaskList;
  final List<Task>? doneTaskList;
  const DoneTaskPage({this.doneTaskList, this.undoneTaskList});

  @override
  _DoneTaskPageState createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.doneTaskList!.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(widget.doneTaskList![index].title!),
            value: widget.doneTaskList![index].isDone,
            onChanged: (bool? value) {
              widget.doneTaskList![index].isDone = !widget.doneTaskList![index].isDone!;
              widget.doneTaskList!.removeAt(index);
              setState(() {});
            },
          );
        }
    );
  }
}
