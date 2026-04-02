import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/widgets/bottomNav.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> cursoSelecionados = [];
  List<String> professoresSelecionados = [];
  TextEditingController relatorioController = TextEditingController();
  bool podeSalvar = false;

  Widget _campoSelecionado({
    required List<String> selecionados,
    required String label,
    required VoidCallback onBuscar,
    required Function(String) onRemover,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: regular),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: corEscuro),
          ),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 4,
                  children: selecionados
                      .map(
                        (item) => Chip(
                          label: Text(item),
                          onDeleted: () => onRemover(item),
                        ),
                      )
                      .toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: onBuscar,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _abrirModal(
    BuildContext context,
    List<String> opcoes,
    List<String> selecionados,
    Function(List<String>) onConfirmar,
  ) {
    List<String> temp = List.from(selecionados);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: Text('Selecionar'),
          content: SingleChildScrollView(
            child: Column(
              children: opcoes
                  .map(
                    (op) => CheckboxListTile(
                      value: temp.contains(op),
                      title: Text(op),
                      onChanged: (val) {
                        setModalState(() {
                          val! ? temp.add(op) : temp.remove(op);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                onConfirmar(temp);
                Navigator.pop(context);
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _gerarRelatorio() {
    if (cursoSelecionados.isEmpty || professoresSelecionados.isEmpty)
      return;
    final texto =
        '''
Cursos: ${cursoSelecionados.join(',')}
Professores: ${professoresSelecionados.join(',')}
 ''';

    setState(() {
      relatorioController.text = texto;
      podeSalvar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainPage(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 50),
            Text('Relatórios', style: black),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _campoSelecionado(
                selecionados: cursoSelecionados,
                label: 'Curso',
                onBuscar: () => _abrirModal(
                  context,
                  ['Matematica', 'Ingles', 'Programacao'],
                  cursoSelecionados,
                  (lista) =>
                      setState(() => cursoSelecionados = lista),
                ),
                onRemover: (item) =>
                    setState(() => cursoSelecionados.remove(item)),
              ),
              SizedBox(height: 16),
              _campoSelecionado(
                selecionados: professoresSelecionados,
                label: 'Professor',
                onBuscar: () => _abrirModal(
                  context,
                  ['Douglas', 'KG', 'Wellington'],
                  professoresSelecionados,
                  (lista) =>
                      setState(() => professoresSelecionados = lista),
                ),
                onRemover: (item) => setState(
                  () => professoresSelecionados.remove(item),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                child: ElevatedButton(
                  onPressed: _gerarRelatorio,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corRoxoMedio,
                    foregroundColor: corClara,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.horizontal(),
                    ),
                    fixedSize: Size(170, 40)
                  ),
                  child: Text('Gerar Relatorio', style: regular,),
                ),
              ),
              SizedBox(height: 16,),
              Expanded(child: TextField(
                controller: relatorioController,
                readOnly: true,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
      paginaAtual: 2,
    );
  }
}
