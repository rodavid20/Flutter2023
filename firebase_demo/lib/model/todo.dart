class Todo {
  String? id;
  String title;
  bool isDone;

  Todo({this.id, required this.title, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> todo) {
    return Todo(
      id: todo['id'],
      title: todo['title'],
      isDone: todo['isDone'],
    );
  }
}
