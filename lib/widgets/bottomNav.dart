import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    this.appBar,
    this.floatingActionButton,
    required this.body,
    required this.paginaAtual,
    super.key,
  });

  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final int paginaAtual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corClara,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: paginaAtual,
        backgroundColor: corClara,
        selectedItemColor: corRoxoClaro,
        unselectedItemColor: corEscuro,
        onTap: (index) {
          if (index == paginaAtual) return;

          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/home');
              break;
            case 1:
              Navigator.of(
                context,
              ).pushReplacementNamed('/teachers');
              break;
            case 2:
              Navigator.of(
                context,
              ).pushReplacementNamed('/reports');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Opacity(opacity: paginaAtual == 0 ? 0.5 : 1.0,
            child: Image.asset('assets/images/cursos.png',
            width: 70,
            height: 70,)),
            label: 'Cursos'
            ),
            BottomNavigationBarItem(
            icon: Opacity(
              opacity: paginaAtual == 1 ? 0.5 : 1.0,
              child: Image.asset('assets/images/profs.png',
              width: 70,
              height: 70,),
            ),
            label: 'Professores'
            ),
            BottomNavigationBarItem(
            icon: Opacity(
              opacity: paginaAtual == 2 ? 0.5 : 1.0,
              child: Image.asset('assets/images/relatorios.png',
              width: 70,
              height: 70,),
            ),
            label: 'Relatórios'
            ),
        ],
      ),
    );
  }
}
