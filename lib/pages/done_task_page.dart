import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class DoneTaskPage extends StatefulWidget {

  @override
  _DoneTaskPageState createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  TextEditingController editTitleController = TextEditingController();
  List<Task> undoneTaskList = [];
  List<Task> doneTaskList = [];

  Future<void> getDoneTasks() async {
    var collection = FirebaseFirestore.instance.collection('task');
    var snapshot = await collection.where('is_done', isEqualTo: true).get();
    snapshot.docs.forEach((task) {
      Task doneTask = Task(
        title: task['title'],
        isDone: task['is_done'],
        createdTime: task['created_time'],
      );
      doneTaskList.add(doneTask);
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoneTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: doneTaskList.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(doneTaskList[index].title!),
            value: doneTaskList[index].isDone,
            onChanged: (bool? value) {
              doneTaskList[index].isDone = value;
              undoneTaskList.add(doneTaskList[index]);
              doneTaskList.removeAt(index);
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
                                          controller: editTitleController,
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
                                          child: ElevatedButton(
                                              onPressed: (){
                                                doneTaskList[index].title = editTitleController.text;
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Text('編集')
                                          )
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
                          // ボトムシートを非表示に
                          Navigator.pop(context);
                          // 確認用ダイアログの表示
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('${doneTaskList[index].title}を削除しますか？'),
                              actions: [    // アラートダイアログに設置するボタン
                                TextButton(
                                    onPressed: (){
                                      doneTaskList.removeAt(index);
                                      Navigator.pop(context);
                                      setState(() {});
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
