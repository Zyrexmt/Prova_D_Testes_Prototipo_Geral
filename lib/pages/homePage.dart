import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:teste/appWidget.dart';
import 'package:teste/widgets/bottomNav.dart';
import 'package:teste/widgets/cursoPorcentagem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isListed = 0;

  @override
  Widget build(BuildContext context) {
    return MainPage(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 40),
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              //Navigator.of(context).pushReplacementNamed('/teachers');
              setState(() {
                isListed = 0;
              });
            },
            child: Opacity(
              opacity: isListed == 0 ? 0.3 : 1.0,
              child: Image.asset('assets/images/grid.png'),
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              //Navigator.of(context).pushReplacementNamed('/teachers');
              setState(() {
                isListed = 1;
              });
            },
            child: Opacity(
              opacity: isListed == 1 ? 0.3 : 1.0,
              child: Image.asset('assets/images/lista.png'),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Busca',
                  suffixIcon: Image.asset('assets/images/lupa.png'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              isListed == 0 ?
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            children: [
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                            ],
                          ),

                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            children: [
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                              _itemCursoCard('Matematica', 0.7),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              : Flexible(
                child: Column(
                  children: [_itemCursoList('Matematica', 1.0)],
                ),
              ),
            ],
          ),
        ),
      ),
      paginaAtual: 0,
    );
  }
}

Widget _itemCursoCard(String nome, double porcentagem) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
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
              Text(
                '${(porcentagem * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(nome),
      ],
    ),
  );
}

Widget _itemCursoList(String nome, double porcentagem) {
  return Padding(
    padding: EdgeInsetsGeometry.all(10),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.horizontal(),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: ArcoPorcentagem(
                        porcentagem: porcentagem,
                      ),
                      size: Size(80, 980),
                    ),
                    Text(
                      '${(porcentagem * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 25,),
            Text('Matematica', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    ),
  );
}
