import 'package:db_demo/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'model/todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _titleController = TextEditingController();

  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isDone,
                    onChanged: (value) {},
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Enter a new Task'),
                  ),
                ),
                IconButton(onPressed: _addTodo, icon: Icon(Icons.add))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper.instance.getAllToDos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _addTodo() async {
    final title = _titleController.text;
    if (title.isNotEmpty) {
      final todo = Todo(title: title);
      await DatabaseHelper.instance.insertToDo(todo);
      _titleController.clear();
      _loadTodos();
    }
  }
}
