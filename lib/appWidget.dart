import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teste/homePage.dart';

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
      routes: {'/': (context) => const HomePage()},
      initialRoute: '/',
    );
  }
}

class ArcoPorcentagem extends CustomPainter {
  final double porcentagem;

  ArcoPorcentagem({required this.porcentagem});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = Color(0xff5a00fb)
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final inicio = pi * 0.75;
    final extensaoTotal = pi * 1.5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      inicio,
      extensaoTotal,
      false,
      paint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      inicio,
      extensaoTotal * porcentagem,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ArcoPorcentagem old) {
    return old.porcentagem != porcentagem;
  }
}


