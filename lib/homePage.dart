import 'package:flutter/material.dart';
import 'package:teste/appWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),


                      
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),
                      _itemCurso('Matematica', 0.7),

                    ],
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

Widget _itemCurso(String nome, double porcentagem) {
  return Column(children: [
    SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(100, 100),
            painter: ArcoPorcentagem(porcentagem: porcentagem),
          ),
          Text('${(porcentagem*100).toInt()}%',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
        ],
      ),
    ),
    SizedBox(height: 6,),
    Text(nome)
    ],
  );
}