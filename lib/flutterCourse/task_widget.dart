import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db_Helper.dart';
import 'task_model.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function fun;
  TaskWidget(this.task, this.fun);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isCompleteds = widget.task.isComplete == 1 ? true : false;
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  DBHelper.dbHelper.deleteTask(Task(
                       widget.task.taskName,
                       widget.task.isComplete));
                  setState(() {});
                }),
            Text(widget.task.taskName),
            Checkbox(
                value: isCompleteds,
                // widget.task.isComplete == 1 ? true : false,
                onChanged: (value) {
                  setState(() {
                    isCompleteds = value;
                  });
                  // value = widget.task.isComplete == 1 ? true : false;
                  DBHelper.dbHelper.updateTask(Task(
                       widget.task.taskName,
                       widget.task.isComplete));
                  setState(() {});
                  widget.fun();
                })
          ],
        ),
      ),
    );
  }
}
