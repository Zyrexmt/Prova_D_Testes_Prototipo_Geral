import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:teste/appWidget.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/widgets/bottomNav.dart';
import 'package:teste/widgets/cursoPorcentagem.dart';

class Cursos {
  final String nome;
  final int percent;
  Cursos(this.nome, this.percent);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isListed = 0;

  TextEditingController buscaController = TextEditingController();
  void modal() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.horizontal(),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Informações'),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Curso:\nMatematica'),
              SizedBox(height: 10),
              Text('Descricao:\nCursos de calculos'),
              SizedBox(height: 10),
              Text('Incritos:\n10'),
              SizedBox(height: 10),
              Text('Ativos:\n8'),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  List<Cursos> cursoListados = [];
  List<Cursos> cursos = [
    Cursos('Matematica', 90),
    Cursos('Ingles', 50),
    Cursos('Programacao', 10),
    Cursos('Portugues', 60),
  ];

  @override
  void initState() {
    super.initState();
    cursoListados = cursos;
  }

  void _buscar() {
    final texto = buscaController.text.toLowerCase();
    setState(() {
      if (texto.isEmpty) {
        cursoListados = List.from(cursos);
      } else {
        cursoListados = cursos
            .where((c) => c.nome.toLowerCase().contains(texto))
            .toList();
      }
    });
  }

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
                controller: buscaController,
                decoration: InputDecoration(
                  hintText: 'Busca',
                  suffixIcon: IconButton(
                    icon: Image.asset('assets/images/lupa.png'),
                    onPressed: _buscar,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              isListed == 0
                  ? Flexible(
                      child: GridView.builder(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                        itemCount: cursoListados.length,
                        itemBuilder: (_, index) {
                          final curso = cursoListados[index];
                          return GestureDetector(
                            onTap: () => modal(),
                            child: _itemCursoCard(
                              curso.nome,
                              curso.percent / 100,
                            ),
                          );
                        },
                      ),
                    )
                  : Flexible(
                      child: ListView.builder(
                        itemCount: cursoListados.length,
                        itemBuilder: (_, index) {
                          final curso = cursoListados[index];
                          return GestureDetector(
                            onTap: () => modal(),
                            child: _itemCursoList(
                              curso.nome,
                              curso.percent / 100,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      paginaAtual: 0,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/curso');
        },
        backgroundColor: Colors.white,
        child: SizedBox(
          width: 70,
          height: 70,
          child: Container(
            margin: EdgeInsets.all(5),
            child: Image.asset('assets/images/mais.png'),
          ),
        ),
      ),
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
  return Container(
    margin: EdgeInsets.only(top: 5),
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
                    size: Size(80, 80),
                  ),
                  Text(
                    '${(porcentagem * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 25),
          Text(
            nome,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
