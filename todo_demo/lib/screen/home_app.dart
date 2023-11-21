import 'package:flutter/material.dart';
import 'package:todo_demo/screen/todo_list.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoList(),
    );
  }
}
