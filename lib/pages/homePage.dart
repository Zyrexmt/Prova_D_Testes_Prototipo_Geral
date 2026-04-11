import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste/appWidget.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/services/data_service.dart';
import 'package:teste/widgets/bottomNav.dart';
import 'package:teste/widgets/cursoPorcentagem.dart';

class Cursos {
  final String nome;
  final int percent;
  final Map<String, dynamic> cursoData;
  Cursos(this.nome, this.percent, this.cursoData);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  int isListed = 0;

  TextEditingController buscaController = TextEditingController();
  void modal(Map<String, dynamic> cursoData) {
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
              Text('Curso:\n${cursoData['nomeCompleto'] ?? 'N/A'}'),
              SizedBox(height: 10),
              Text('Descrição:\n${cursoData['descricao'] ?? 'N/A'}'),
              SizedBox(height: 10),
              Text(
                'Categoria:\n${cursoData['categoria_id'] ?? 'N/A'}',
              ),
              SizedBox(height: 10),
              Text('Formato:\n${cursoData['formato'] ?? 'N/A'}'),
              SizedBox(height: 10),
              Text('Início:\n${cursoData['dataInicio'] ?? 'N/A'}'),
              SizedBox(height: 10),
              Text('Fim:\n${cursoData['dataFim'] ?? 'N/A'}'),
              SizedBox(height: 10),
              Text(
                'Professores:\n${DataService.getProfessoresDoCurso(cursoData).map((p) => p['nome']).join(', ')}',
              ),
            ],
          ),
        );
      },
    );
  }

  List<Cursos> cursoListados = [];
  List<Cursos> cursos = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    await DataService.carregar();

    setState(() {
      cursos = DataService.cursos
          .where((c) => c['visivel'] == true)
          .map((cursoData) {
            final nome =
                cursoData['nomeCompleto']?.toString() ?? 'Sem nome';
            final percent = ((cursoData['porcentagem'] ?? 0) * 100)
                .round()
                .clamp(0, 100);
            return Cursos(nome, percent, cursoData);
          })
          .where((c) => c.nome.isNotEmpty)
          .toList();

      cursoListados = List.from(cursos);
      isLoading = false;
    });
  }

  void _buscar() {
    final texto = buscaController.text.toLowerCase();
    setState(() {
      if (texto.isEmpty) {
        cursoListados = List.from(cursos);
      } else if (texto.contains(RegExp(r'[@#$]'))) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Caracteres inválidos não são aceitos'),
          ),
        );
        return;
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
          padding: EdgeInsets.all(20),
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
                onSubmitted: (_) => _buscar(),
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
                            onTap: () => modal(curso.cursoData),
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
                            onTap: () => modal(curso.cursoData),
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
