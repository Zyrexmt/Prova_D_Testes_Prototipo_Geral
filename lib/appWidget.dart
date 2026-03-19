import 'package:flutter/material.dart';
import 'package:teste/pages/homePage.dart';
import 'package:teste/pages/teacherPage.dart';

class AppController extends StatelessWidget {
  const AppController({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
        '/teachers': (context) => const TeacherPage(),

        },
      initialRoute: '/home',
    );
  }
}


