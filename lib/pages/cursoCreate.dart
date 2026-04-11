import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/services/data_service.dart';

class CursoCreate extends StatefulWidget {
  const CursoCreate({super.key});

  @override
  State<CursoCreate> createState() => _CursoCreateState();
}

class _CursoCreateState extends State<CursoCreate> {
  TextEditingController buscaController = TextEditingController();

  TextEditingController nomeCompletoController =
          TextEditingController(),
      nomeBreveController = TextEditingController(),
      dataInicioController = TextEditingController(),
      dataFimController = TextEditingController(),
      descricaoCursoController = TextEditingController();

  List<Map<String, dynamic>> get categorias => DataService.categorias;
  List<Map<String, dynamic>> get professores =>
      DataService.professores;
  List<Map<String, dynamic>> filtrados = [];
  List<Map<String, dynamic>> professoresSelecionados = [];
  List<String> formatos = [
    'Atividade Única',
    'Formato Social',
    'Formato tópicos',
    'Formato semanal',
  ];

  Map<String, dynamic>? categoriaSelecionada;
  String? formatoSelecionado;
  bool visivel = false;

  @override
  void initState() {
    super.initState();
    filtrados = List.from(professores);
  }

  void _salvar() async {
    final novoCurso = {
      'id': DateTime.now().millisecondsSinceEpoch,
      "nomeCompleto": nomeCompletoController.text,
      "nomeBreve": nomeBreveController.text,
      "categoria_id": categoriaSelecionada?['id'],
      "visivel": visivel,
      "dataInicio": dataInicioController.text,
      "dataFim": dataFimController.text,
      "descricao": descricaoCursoController.text,
      "formato": formatoSelecionado,
      "professores_id": professoresSelecionados
          .map((p) => p['id'])
          .toList(),
      "porcentagem": 0.0,
    };
    if (nomeCompletoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nome completo é obrigatório')),
      );
      return;
    }
    if (nomeCompletoController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nome completo precisa ter no mínimo 10 caracteres',
          ),
        ),
      );
      return;
    }
    if (DateTime.parse(dataInicioController.text).isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data de ínicio não pode ser anterior ao dia atual',
          ),
        ),
      );
      return;
    }
    if (DateTime.parse(
      dataFimController.text,
    ).isBefore(DateTime.parse(dataInicioController.text))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data de fim não pode ser anterior ao data de início',
          ),
        ),
      );
      return;
    }
    if (professoresSelecionados.length > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Os cursos devem possuir no máximo 5 professsores',
          ),
        ),
      );
      return;
    }
    if (professoresSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione ao menos um professor')),
      );
      return;
    }
    await DataService.adicionarCurso(novoCurso);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void modal() {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Container(
                width: 280,
                constraints: BoxConstraints(maxHeight: 450),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Professores', style: black),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('X', style: black),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: corEscuro,
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: corEscuro),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: buscaController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: corClara,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.horizontal(),
                                ),
                                hintText: 'Busca',
                                suffixIcon: Image.asset(
                                  'assets/images/lupa.png',
                                ),
                                hintStyle: bold,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 8,
                                ),
                                isDense: true,
                              ),
                              onChanged: (value) {
                                setStateModal(() {
                                  filtrados = professores
                                      .where(
                                        (p) => p['nome']
                                            .toLowerCase()
                                            .contains(
                                              value.toLowerCase(),
                                            ),
                                      )
                                      .toList();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtrados.length,
                        itemBuilder: (context, index) {
                          final professor = filtrados[index];
                          final selecionado = professoresSelecionados
                              .contains(professor);

                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    professor['nome'],
                                    style: regular,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setStateModal(() {
                                      if (selecionado) {
                                        professoresSelecionados
                                            .remove(professor);
                                      } else if (professoresSelecionados.length < 5){
                                        professoresSelecionados.add(
                                          professor,
                                        );
                                      }
                                    });
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: corEscuro,
                                      ),
                                    ),
                                    child: selecionado
                                        ? Icon(Icons.add)
                                        : Icon(Icons.remove),
                                  ),
                                ),

                                SizedBox(width: 6),

                                GestureDetector(
                                  onTap: () {
                                    setStateModal(() {
                                      if (selecionado) {
                                        professoresSelecionados
                                            .remove(professor);
                                      } else {
                                        professoresSelecionados.add(
                                          professor,
                                        );
                                      }
                                    });
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: corEscuro,
                                      ),
                                    ),
                                    child: selecionado
                                        ? Icon(Icons.check)
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

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
                  maxLength: 50,
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
                  maxLength: 15,
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
                              value: categoriaSelecionada,
                              items: categorias.map((cat) {
                                return DropdownMenuItem<
                                  Map<String, dynamic>
                                >(
                                  value: cat,
                                  child: Text(cat['nome']),
                                );
                              }).toList(),
                              onChanged: (valor) {
                                setState(() {
                                  categoriaSelecionada = valor;
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
                                  dataInicioController.text = data.toString();
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
                                  dataFimController.text = data.toString();
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
                  maxLength: 200,
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
                        value: formatoSelecionado,
                        items: formatos.map((form) {
                          return DropdownMenuItem<String>(
                            value: form,
                            child: Text(form),
                          );
                        }).toList(),
                        onChanged: (valor) {
                          setState(() {
                            formatoSelecionado = valor;
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
                                : modal,
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
                      onPressed: _salvar,
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
                    key: Key(professor['nome']),
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
                      title: Text(professor['nome']),
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

  Widget _selecionarProfessores() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Professor', style: regular),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: corEscuro),
                  ),
                  child: Icon(Icons.add),
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: corEscuro),
                  ),
                  child: Icon(Icons.youtube_searched_for),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
