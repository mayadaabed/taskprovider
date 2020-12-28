import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'flutterCourse/task_model.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasks.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskisComplete = 'isComplete';
  Database database;
  List<Task> tasks;

  Future<Database> initData() async {
    if (database == null) {
      return await createDatabase();
    } else
      return database;
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath + databaseName);
      Database database =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
          $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $taskNameColumnName TEXT NOT NULL,
          $taskisComplete INTEGER
        ) ''');
      });
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<Task> insertnewTask(Task task) async {
    try {
      database = await initData();
      int id = await database.insert(tableName, task.toJson());
    } on Exception catch (e) {
      print(e);
    }
    return task;
  }

  Future<List<Task>> selectAllTasks() async {
    try {
      database = await initData();

      List<Map> result = await database.query(tableName);
      // List<Task> tasks = result.map<Task>((e) => Task().toJson()).toList();
      // print(result);
      // return tasks;
      List<Task> carts = [];
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          carts.add(Task.fromMap(result[i]));
        }
      }
      return carts;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Task>> selectSpicifiTask(int name) async {
    try {
      database = await initData();
      List<Map> result = await database
          .query(tableName, where: '$taskisComplete=?', whereArgs: [name]);
      print(result);
      List<Task> carts = [];
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          carts.add(Task.fromMap(result[i]));
        }
      }
      return carts;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initData();
      int result = await database.update(tableName, task.toMap(),
          where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(Task task) async {
    try {
      database = await initData();
      int result = await database.delete(tableName,
          where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
