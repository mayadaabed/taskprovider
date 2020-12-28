import 'package:flutter/cupertino.dart';
import 'flutterCourse/task_model.dart';

class ProviderModel extends ChangeNotifier {
  Task task;

  setValues(String taskName1, int isComplete1) {
    Task task1 = Task(taskName1, isComplete1);
    
    notifyListeners();
  }
}
