import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:layout/database_helper.dart';
import 'package:layout/models/task.dart';
import 'package:layout/screens/taskpage.dart';
import 'package:layout/widgets/taskcard.dart';
import 'package:layout/widgets/todowidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          color: const Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 32.0,
                    ),
                    child: const Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: const [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        final List<Task> tasks = snapshot.data as List<Task>;
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                        task: tasks[index],
                                      ),
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: TaskCardWidget(
                                    title: tasks[index].title,
                                    desc: tasks[index].description),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(task: Task()),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Image(
                      image: AssetImage(
                        "assets/images/add_icon.png",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
