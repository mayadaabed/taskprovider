import '../db_Helper.dart';

class Task {
  int isComplete;
  String taskName;
  Task(this.taskName, this.isComplete);

  toJson() {
    return {
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskisComplete: this.isComplete 
    };
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': taskName,
      'isComplete': this.isComplete == true ? 1 : 0,
    };
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    taskName = map['name'];
    isComplete== true ? map['isComplete'] :map['isComplete'];
  }
}
