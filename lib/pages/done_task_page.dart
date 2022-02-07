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
              widget.doneTaskList![index].isDone = value;
              widget.undoneTaskList?.add(widget.doneTaskList![index]);
              widget.doneTaskList!.removeAt(index);
              setState(() {});
            },
            secondary: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('編集'),
                        leading: Icon(Icons.edit),
                        onTap: () {
                          // ボトムシートを非表示
                          Navigator.pop(context);
                          // 編集用ダイアログの表示
                          showDialog(context: context, builder: (context) {
                            return SimpleDialog(
                              titlePadding: EdgeInsets.all(20),
                              title: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text('タイトルを編集'),
                                    Container(
                                        width: 500,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder()
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: Container(
                                          width: 200,
                                          height: 30,
                                          child: ElevatedButton(onPressed: (){}, child: Text('編集'))
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ),
                      ListTile(
                        title: Text('削除'),
                        leading: Icon(Icons.delete),
                        onTap: () {
                          // 削除の処理
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
