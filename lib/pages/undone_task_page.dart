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
            secondary: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: (){
                // ボトムシートを表示
                showModalBottomSheet(context: context, builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,         // Column全体のサイズを要素ににあわせて小さくする
                    children: [
                      ListTile(
                        title: Text('編集'),
                        leading: Icon(Icons.edit),
                        onTap: () {
                          // 編集の処理
                        },
                      ),
                      ListTile(
                        title: Text('削除'),
                        leading: Icon(Icons.delete),
                        onTap: () {
                          // 編集の処理
                        },
                      )
                    ],
                  );
                });
              },
            ),
          );
        }
    );
  }
}
