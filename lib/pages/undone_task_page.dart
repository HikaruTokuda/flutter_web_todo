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
