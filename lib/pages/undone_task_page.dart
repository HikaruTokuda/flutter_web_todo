import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class UndoneTaskPage extends StatefulWidget {
  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  TextEditingController editTitleController = TextEditingController();

  List<Task> undoneTaskList = [];
  List<Task> doneTaskList = [];

  Future<void> getUndoneTasks() async {
    var collection = FirebaseFirestore.instance.collection('task');

    var snapshot = await collection.where('is_done', isEqualTo: false).get();
    snapshot.docs.forEach((task) {
      Task undoneTask = Task(
        title: task['title'],
        isDone: task['is_done'],
        createdTime: task['created_time'],
      );
      undoneTaskList.add(undoneTask);
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUndoneTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: undoneTaskList.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(undoneTaskList[index].title!),
            value: undoneTaskList[index].isDone,
            onChanged: (bool? value) {
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
                        },
                      ),
                      ListTile(
                        title: Text('削除'),
                        leading: Icon(Icons.delete),
                        onTap: () {
                          // ボトムシートを非表示に
                          Navigator.pop(context);
                          // 確認用ダイアログの表示
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('${undoneTaskList[index].title}を削除しますか？'),
                              actions: [    // アラートダイアログに設置するボタン
                                TextButton(
                                    onPressed: (){
                                    },
                                    child: Text('はい')
                                ),
                                TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text('キャンセル')
                                )
                              ],
                            );
                          });
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
