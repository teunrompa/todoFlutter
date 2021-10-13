import 'package:flutter/material.dart';
import 'package:layout/database_helper.dart';
import 'package:layout/models/task.dart';
import 'package:layout/models/todo.dart';
import 'package:layout/widgets/todowidget.dart';
import 'package:sqflite/sqflite.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  FocusNode _titleFocus, _descriptionFocus, _todoFocus;


  String _taskTitle = "";
  int _taskId = 0;

  @override
  void initState() {
    _taskTitle = widget.task.title;
    _taskId = widget.task.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Image(
                            image: AssetImage(
                              "assets/images/back_arrow_icon.png",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            print("Field Value: $value");
                            if (value != "") {
                              DatabaseHelper _dbHelper = DatabaseHelper();
                              Task _newTask = Task(title: value);
                              await _dbHelper.insertTask(_newTask);
                              // setState(() {});
                            }
                          },
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: const InputDecoration(
                            hintText: "Enter Task Title",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter Description for the task",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
                  ),
                ),
                FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodos(_taskId),
                    builder: (context, snapshot) {
                      final List<ToDo>? todos = snapshot.data as List<ToDo>?;
                      return todos == null
                          ? const Text("(undefined Task)")
                          : Expanded(
                              child: ListView.builder(
                                itemCount: todos.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      //Switch the checkbox
                                    },
                                    child: ToDoWidget(
                                        text: todos[index].title,
                                        isDone: todos[index].isDone == 0
                                            ? false
                                            : true),
                                  );
                                },
                              ),
                            );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        margin: const EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                                color: const Color(0xFF86829D), width: 1.5)),
                        child: const Image(
                          image: AssetImage('assets/images/check_icon.png'),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            DatabaseHelper _dbHelper = DatabaseHelper();
                            ToDo _newToDo = ToDo(
                              taskId: widget.task.id,
                              title: value,
                              isDone: 0,
                            );
                            await _dbHelper.insertToDo(_newToDo);
                            setState(() {});
                            print("Creating new todo");
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Todo item...",
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskPage(task: widget.task),
                    ),
                  );
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE3577),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Image(
                    image: AssetImage(
                      "assets/images/delete_icon.png",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
