import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/widgets/bottomNav.dart';

class _RelatorioPageState extends State<RelatorioPage> {
  List<String> cursoSelecionados = [];
  List<String> professoresSelecionados = [];
  TextEditingController relatorioController = TextEditingController();
  bool podeSalvar = false;
}

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  
  @override
  Widget build(BuildContext context) {
    return MainPage(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 5),
            Text('Relatórios', style: black),
          ],
        ),
      ),
      body: SizedBox(),
      paginaAtual: 2,
    );
  }
}
