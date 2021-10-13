import 'package:layout/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/task.dart';


class DatabaseHelper {

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async{
        await db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT) ');
        await db.execute('CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER) ');
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database _db = await database();
    await _db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertToDo(ToDo todo) async {
    Database _db = await database();
    await _db.insert('todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index){
      return Task(id: taskMap[index]['id'], title: taskMap[index]['title'], description: taskMap[index]['description']);
    });
  }

  Future<List<ToDo>> getTodos(int taskId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
    return List.generate(todoMap.length, (index){
      return ToDo(id: todoMap[index]['id'], taskId: todoMap[index]['taskId'], title: todoMap[index]['title'], isDone: todoMap[index]['isDone']);
    });
  }

}