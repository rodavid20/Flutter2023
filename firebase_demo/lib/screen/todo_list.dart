import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _titleController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('todos').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final todosDocs = snapshot.data!.docs;
              final List<Todo> todos = [];
              for (var todo in todosDocs) {
                todos.add(Todo.fromMap(todo.data() as dynamic));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
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
                            decoration:
                                InputDecoration(hintText: 'Enter a new Task'),
                          ),
                        ),
                        IconButton(onPressed: _addTodo, icon: Icon(Icons.add))
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }

  Future<void> _loadTodos() async {
    setState(() {});
  }

  Future<void> _addTodo() async {
    final title = _titleController.text;
    if (title.isNotEmpty) {
      final todo = Todo(title: title);
      final docRef = await FirebaseFirestore.instance.collection('todos').add(
            todo.toMap(),
          );
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(docRef.id)
          .update(
        {'id': docRef.id},
      );
      _titleController.clear();
      _loadTodos();
    }
  }

  Future<void> _updateTodo(Todo todo) async {
    await FirebaseFirestore.instance.collection('todos')
    .doc(todo.id).update(
      {'isDone': todo.isDone},
    );
  }

  Future<void> _deleteTodo(Todo todo) async {
    await FirebaseFirestore.instance.collection('todos').doc(todo.id).delete();
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
