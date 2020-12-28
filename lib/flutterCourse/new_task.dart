import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db_Helper.dart';
import '../providermodel.dart';
import 'task_model.dart';

class NewTasks extends StatefulWidget {
  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  bool isComplete = false;
  int iscompInt = 0;
  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new Tasks'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Checkbox(
                value: isComplete,
                onChanged: (value) {
                  value ? iscompInt = 1 : iscompInt = 0;
                  setState(() {});
                }),
            RaisedButton(
                child: Text('Add New Task'),
                onPressed: () {
                  Task task = Task(this.taskName, this.iscompInt);
                  DBHelper.dbHelper.insertnewTask(task);
                  Provider.of<ProviderModel>(context, listen: false)
                      .setValues(this.taskName, this.iscompInt);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
