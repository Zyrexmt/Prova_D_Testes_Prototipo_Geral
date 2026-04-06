import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/widgets/bottomNav.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  @override
  void initState() {
    super.initState();
    relatorioController.addListener(() {
      setState(() {
        podeSalvar = relatorioController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    relatorioController.dispose();
    super.dispose();
  }

  Future<void> _salvarPDF() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permiassão de armazenamento negada.'),
          ),
        );
      }
      return;
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Relatório',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                relatorioController.text,
                style: const pw.TextStyle(fontSize: 16),
              ),
            ],
          );
        },
      ),
    );

    try {
      Directory? dowloadsDir;
      if (Platform.isAndroid) {
        dowloadsDir = Directory('/storage/emulated/0/Download');
        if (!await dowloadsDir.exists()) {
          dowloadsDir = await getExternalStorageDirectory();
        }
      } else {
        dowloadsDir = await getExternalStorageDirectory();
      }

      if (dowloadsDir == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Não foi possível acessar a pasta Downloads',
              ),
            ),
          );
        }
        return;
      }
      final timeStamp = DateTime.now().millisecondsSinceEpoch;
      final file = File(
        '${dowloadsDir.path}/relatorio_$timeStamp.pdf',
      );
      await file.writeAsBytes(await pdf.save());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF salvo em: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar pdf: $e')),
        );
      }
    }
  }

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
                    fixedSize: Size(170, 40),
                  ),
                  child: Text('Gerar Relatorio', style: regular),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: relatorioController,
                  readOnly: true,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      paginaAtual: 2,
      floatingActionButton: FloatingActionButton(
        onPressed: podeSalvar ? _salvarPDF :null,
        backgroundColor: corClara,
      child: Opacity(
        opacity: podeSalvar? 1.0 : 0.5,
        child: SizedBox(
          width: 70,
          height: 70,
          child: Container(
            margin: EdgeInsets.all(5),
            child: Image.asset('assets/images/mais.png'),
          ),
        ),
      ),
      ),
    );
  }
}
