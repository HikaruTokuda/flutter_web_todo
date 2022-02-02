import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class UndoneTaskPage extends StatefulWidget {
  final List<Task>? undoneTaskList;
  final List<Task>? doneTaskList;
  const UndoneTaskPage({this.doneTaskList, this.undoneTaskList});

  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.undoneTaskList!.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(widget.undoneTaskList![index].title!),
            value: widget.undoneTaskList![index].isDone,
            onChanged: (bool? value) {
              widget.undoneTaskList![index].isDone = value;
              widget.doneTaskList?.add(widget.undoneTaskList![index]);
              widget.undoneTaskList!.removeAt(index);
              setState(() {});
            },
          );
        }
    );
  }
}
