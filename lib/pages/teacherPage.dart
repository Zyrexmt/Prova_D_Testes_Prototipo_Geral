import 'package:flutter/material.dart';
import 'package:teste/widgets/bottomNav.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return MainPage(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(padding: EdgeInsetsGeometry.symmetric(),),
      ),
      
      paginaAtual: 1);
  }
}