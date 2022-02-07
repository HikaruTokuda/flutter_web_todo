import 'package:flutter/material.dart';
import 'package:flutter_web/models/task.dart';
import 'package:flutter_web/pages/add_task_page.dart';
import 'package:flutter_web/pages/done_task_page.dart';
import 'package:flutter_web/pages/undone_task_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Task> doneTaskList = [];

  bool showUndoneTaskPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Firebase * Flutter for Web'),
      ),
      body: Stack(            // Stack: 複数のWidgetを重ねて表示する
        alignment: Alignment.bottomCenter,    // childrenのWedigetを下詰め中央寄せで表示
        children: [
          showUndoneTaskPage ? UndoneTaskPage(doneTaskList: doneTaskList, undoneTaskList: undoneTaskList) : DoneTaskPage(doneTaskList: doneTaskList, undoneTaskList: undoneTaskList),

          Row(      // Row: 複数のWidgetを横に並べる
            children: [
              Expanded(     // childのWidgetを画面いっぱいに広げる
                child: InkWell(     // childのWidgetをタップ可能にする
                  onTap: () => {
                    showUndoneTaskPage = true,
                    setState(() => {}),
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.redAccent,
                    child: const Text(
                        '未完了タスク',
                        style: TextStyle(color: Colors.white, fontSize: 20),    // TextStyleの設定
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => {
                    showUndoneTaskPage = false,
                    setState(() => {}),
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.greenAccent,
                    child: const Text(
                      '完了タスク',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {       // pushの並列処理を待つ
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskPage(undoneTaskList: undoneTaskList,)));
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}