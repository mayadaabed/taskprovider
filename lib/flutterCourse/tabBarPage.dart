import 'package:flutter/material.dart';
import '../db_Helper.dart';
import 'new_task.dart';
import 'task_model.dart';
import 'task_widget.dart';

class TabBarPage extends StatefulWidget {
  List<Task> tasks;
  TabBarPage({Key key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(Icons.add),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewTasks();
          }));
        },
      ),
      appBar: AppBar(
        title: Text('ToDo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All tasks',
            ),
            Tab(
              text: 'Copmletet tasks',
            ),
            Tab(
              text: 'InComplete tasks',
            )
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [AllTasks(), CompleteTasks(), InCompleteTasks()],
            ),
          ),
        ],
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DBHelper.dbHelper.selectAllTasks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data != null
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskWidget(
                        Task(
                           snapshot.data[index].taskName.toString(),
                           snapshot.data[index].isComplete,
                        ),
                        myFun);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DBHelper.dbHelper.selectSpicifiTask(1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data != null
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskWidget(
                        Task(
                           snapshot.data[index].taskName.toString(),
                           snapshot.data[index].isComplete,
                        ),
                        myFun);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DBHelper.dbHelper.selectSpicifiTask(0),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data != null
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskWidget(
                        Task(
                           snapshot.data[index].taskName.toString(),
                           snapshot.data[index].isComplete,
                        ),
                        myFun);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
