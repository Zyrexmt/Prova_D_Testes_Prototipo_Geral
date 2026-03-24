import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/widgets/bottomNav.dart';

class Professor {
  final String nome;
  final String curso;
  Professor(this.nome, this.curso);
}

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  String busca = '';

  TextEditingController buscaController = TextEditingController();

  final List<Professor> professores = [
    Professor('Douglas', 'TI - Desenvolvimento de Sistemas'),
    Professor('KG', 'TI - Desenvolvimento de Sistemas'),
    Professor('Wellington', 'TI - Desenvolvimento de Sistemas'),
    Professor('Thiago', 'TI - Desenvolvimento de Sistemas'),
    Professor('Douglas', 'TI - Desenvolvimento de Sistemas'),
    Professor('KG', 'TI - Desenvolvimento de Sistemas'),
    Professor('Wellington', 'TI - Desenvolvimento de Sistemas'),
    Professor('Thiago', 'TI - Desenvolvimento de Sistemas'),
  ];

  Widget _listaProfessores() {
    final scollController = ScrollController();
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500),
      child: Scrollbar(
        controller: scollController,
        thumbVisibility: true,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: professores.length,
          itemBuilder: (_, index) =>
              _professorCard(professores[index]),
        ),
      ),
    );
  }

  Widget _professorCard(Professor professor) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: corEscuro)),
      child: Dismissible(
        key: Key(professor.nome),
        direction: DismissDirection.endToStart,
        background: Container(
          color: corRoxoMedio,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.delete, color: corClara),
        ),
        onDismissed: (_) {
          setState(() {
            professores.remove(professor);
          });
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          title: Text(professor.nome, style: bold),
          subtitle: Text(professor.curso, style: bold),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return MainPage(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 30),
            Text('Professores', style: black),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: buscaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                    hintText: 'Busca',
                    suffixIcon: Image.asset('assets/images/lupa.png'),
                  ),
                ),

                SizedBox(height: 50),

                _listaProfessores(),
              ],
            ),
          ),
        ),
      ),
      paginaAtual: 1,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushReplacementNamed('/professorCriar');
        },
        backgroundColor: corClara,
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
