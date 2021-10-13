class ToDo{
  final int id;
  final int taskId;
  final String title;
  final int isDone;


  ToDo({this.id = 0 ,required this.taskId, this.title = '(Unnamed Todo)', this.isDone = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title' : title,
      'isDone' : isDone,
    };
  }
}