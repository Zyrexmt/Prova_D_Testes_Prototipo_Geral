import 'package:flutter/material.dart';
import 'package:teste/pages/cursoCreate.dart';
import 'package:teste/pages/homePage.dart';
import 'package:teste/pages/professorCreate.dart';
import 'package:teste/pages/reportsPage.dart';
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
        '/curso' : (context) => const CursoCreate(),
        '/professorCriar': (context) => const ProfessorCreate(),
        '/reports': (context) => const ReportPage()
        
        

        },
      initialRoute: '/home',
    );
  }
}


