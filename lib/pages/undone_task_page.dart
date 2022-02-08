import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';

class UndoneTaskPage extends StatefulWidget {
  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  TextEditingController editTitleController = TextEditingController();
  CollectionReference? tasks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks = FirebaseFirestore.instance.collection('task');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(    // StreamBuilderはstreamに設定している値に変化があったときに再描画する
      stream: tasks?.snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                if(snapshot.data?.docs[index]['is_done']) return Container();
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(snapshot.data?.docs[index]['title']),
                  value: snapshot.data?.docs[index]['is_done'],
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
                                // ボトムシートを非表示
                                Navigator.pop(context);
                                // 編集用ダイアログの表示
                                showDialog(context: context, builder: (context) {
                                  return SimpleDialog(
                                    titlePadding: const EdgeInsets.all(20),
                                    title: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          const Text('タイトルを編集'),
                                          SizedBox(
                                              width: 500,
                                              child: TextField(
                                                controller: editTitleController,
                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder()
                                                ),
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 30.0),
                                            child: SizedBox(
                                                width: 200,
                                                height: 30,
                                                child: ElevatedButton(
                                                    child: const Text('編集')
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
                                    title: Text('${snapshot.data?.docs[index]['title']}を削除しますか？'),
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
        } else {
          return Container();
        }
      }
    );
  }
}
