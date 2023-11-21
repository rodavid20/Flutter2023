import 'package:flutter/material.dart';
import '../utils/database_helper.dart';
import '../model/todo.dart';

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
                    onChanged: (value) {
                      setState(() {
                        todo.isDone = value!;
                      });
                      _updateTodo(todo);
                    },
                  ),
                  onLongPress: () {
                    _showMyDialog(todo);
                  },
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

  Future<void> _updateTodo(Todo todo) async {
    await DatabaseHelper.instance.updateToDo(todo);
  }

  Future<void> _deleteTodo(Todo todo) async {
    await DatabaseHelper.instance.deleteToDo(todo);
    _loadTodos();
  }

  Future<void> _showMyDialog(Todo todo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(todo.title),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                _deleteTodo(todo);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
