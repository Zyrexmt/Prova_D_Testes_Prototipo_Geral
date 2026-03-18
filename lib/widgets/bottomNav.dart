import 'package:flutter/material.dart';
import 'package:teste/variaveis.dart';

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
              ).pushReplacementNamed('/professores');
              break;
            case 2:
              Navigator.of(
                context,
              ).pushReplacementNamed('/relatorios');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Cursos'
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Professores'
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Relatórios'
            ),
        ],
      ),
    );
  }
}
