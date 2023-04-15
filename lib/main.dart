import 'package:flutter/material.dart';
import 'package:to_do_list_squad_premiun/core/service_locators/service_locator.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To Do List',
      home: HomePage(),
    );
  }
}
