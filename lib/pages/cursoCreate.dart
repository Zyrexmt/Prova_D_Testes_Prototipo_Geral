import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';

class CursoCreate extends StatefulWidget {
  const CursoCreate({super.key});

  @override
  State<CursoCreate> createState() => _CursoCreateState();
}

class _CursoCreateState extends State<CursoCreate> {
  String nomeCompleto = '',
      nomeBreve = '',
      dataInicio = '',
      dataFim = '',
      descricaoCurso = '',
      formato = '';
  TextEditingController nomeCompletoController =
          TextEditingController(),
      nomeBreveController = TextEditingController(),
      dataInicioController = TextEditingController(),
      dataFimController = TextEditingController(),
      descricaoCursoController = TextEditingController(),
      formatoController = TextEditingController();

  List<String> opcoes = ['Opcao 1', 'Opcao 2', 'Opcao 3'];
  List<String> formatos = [
    'Atividade Única',
    'Formato Social',
    'Formato tópicos',
    'Fomarto semanal',
  ];

  List<String> professores = [
    'Douglas',
    'KG',
    'Wellington',
    'Arnaldo',
    'Maria',
  ];
  List<String> professoresSelecionados = [
    'ola',
    'dois',
    'tres',
    'quarto',
    'quarto',
  ];

  String? valorSelecionado;
  String? valorSelecionado2;

  bool visivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 70),
            Text('Cursos-Novo', style: black),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Nome completo', style: regular),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: nomeCompletoController,
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Nome Breve', style: regular),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: nomeBreveController,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text('Categoria', style: regular),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: corClara,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.horizontal(),
                                ),
                              ),
                              value: valorSelecionado,
                              items: opcoes.map((op) {
                                return DropdownMenuItem<String>(
                                  child: Text(op),
                                  value: op,
                                );
                              }).toList(),
                              onChanged: (valor) {
                                setState(() {
                                  valorSelecionado = valor;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 25),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Visivel', style: regular),

                        Switch(
                          activeColor: corRoxoClaro,
                          inactiveTrackColor: corClara,
                          value: visivel,
                          onChanged: (value) {
                            setState(() {
                              visivel = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          right: 5,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                'Data inicío',
                                style: regular,
                              ),
                            ),
                            TextField(
                              controller: dataInicioController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: corClara,
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.horizontal(),
                                ),
                              ),
                              onTap: () async {
                                final data = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2026),
                                  lastDate: DateTime(2050),
                                );
                                if (data != null) {
                                  dataInicioController.text = data
                                      .toString()
                                      .split(' ')
                                      .first;
                                  dataInicio = data.toString();
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 5,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text('Data fim', style: regular),
                            ),
                            TextField(
                              controller: dataFimController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: corClara,
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.horizontal(),
                                ),
                              ),
                              onTap: () async {
                                final data = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2026),
                                  lastDate: DateTime(2050),
                                );

                                if (data != null) {
                                  dataFimController.text = data
                                      .toString()
                                      .split(' ')
                                      .first;
                                  dataFim = data.toString();
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Text('Sumário do Curso', style: regular),
                ),
                TextField(
                  controller: descricaoCursoController,
                  maxLines: null,
                  minLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: corClara,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Formato', style: regular),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: corClara,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        value: valorSelecionado2,
                        items: formatos.map((form) {
                          return DropdownMenuItem<String>(
                            child: Text(form),
                            value: form,
                          );
                        }).toList(),
                        onChanged: (valor) {
                          setState(() {
                            valorSelecionado2 = valor;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Professores', style: regular),
                          IconButton(
                            onPressed:
                                professoresSelecionados.length > 5
                                ? null
                                : () => modal(context),
                            icon: Icon(Icons.add_box_outlined),
                          ),
                        ],
                      ),
                      _listProfessoresSelecionados(),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: corRoxoEscuro,
                        foregroundColor: corClara,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusGeometry.horizontal(),
                        ),
                        fixedSize: Size(70, 40),
                      ),
                      child: Text('Salvar', style: regular),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed('/home');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: corRoxoEscuro,
                        foregroundColor: corClara,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusGeometry.horizontal(),
                        ),
                        fixedSize: Size(70, 40),
                      ),
                      child: Icon(Icons.close, weight: 30),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 void modal(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Professores'),
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Busca',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            _buildProfessorItem('Arnaldo'),
            _buildProfessorItem('Bruna'),
            _buildProfessorItem('Carla'),
            _buildProfessorItem('Douglas'),
            _buildProfessorItem('KG'),
            _buildProfessorItem('Pablo'),
            _buildProfessorItem('Thiago'),
            _buildProfessorItem('Wellington'),
          ],
        ),
      );
    },
  );
}

Widget _buildProfessorItem(String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Row(
          children: [
            IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _listProfessoresSelecionados() {
    final scrollController = ScrollController();
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(8),
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: professoresSelecionados.length,
              itemBuilder: (context, index) {
                final professor = professoresSelecionados[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Dismissible(
                    key: Key(professor),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: corRoxoMedio,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      setState(() {
                        professoresSelecionados.remove(professor);
                      });
                    },
                    child: ListTile(
                      dense: true,
                      title: Text(professor),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
