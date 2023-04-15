import 'package:flutter/material.dart';
import 'package:to_do_list_squad_premiun/features/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      home: const HomePage(),
    );
  }
}
