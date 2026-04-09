import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';
import 'package:teste/services/data_service.dart';
import 'package:teste/widgets/bottomNav.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  TextEditingController buscaController = TextEditingController();

  List<Map<String, dynamic>> professores = [];
  List<Map<String, dynamic>> professoresFiltrados = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    await DataService.carregar();
    setState(() {
      professores = List.from(DataService.professores);
      professoresFiltrados = List.from(professores);
    });
  }

  void _buscar() {
    final texto = buscaController.text.toLowerCase();
    setState(() {
      professoresFiltrados = texto.isEmpty
          ? List.from(professores)
          : professores
                .where(
                  (p) => p['nome'].toString().toLowerCase().contains(
                    texto,
                  ),
                )
                .toList();
    });
  }

  Widget _listaProfessores() {
    final scollController = ScrollController();
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500),
      child: Scrollbar(
        controller: scollController,
        thumbVisibility: true,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: professoresFiltrados.length,
          itemBuilder: (_, index) =>
              _professorCard(professoresFiltrados[index]),
        ),
      ),
    );
  }

  Widget _professorCard(Map<String, dynamic> professor) {
    bool deletando = false;
    return StatefulBuilder(
      builder: (context, setStateCard) {
        return GestureDetector(
          onLongPress: () => setStateCard(() => deletando = true),
          onTap: deletando
              ? () => setStateCard(() => deletando = false)
              : null,
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: corEscuro),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      title: Text(professor['nome'] ?? '', style: bold),
                      subtitle: Text(
                        professor['descricao'] ?? '',
                        style: bold,
                      ),
                    ),
                  ),
                  if (deletando)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          professores.remove(professor);
                          professoresFiltrados.remove(professor);
                        });
                        DataService.removerProfessor(professor);
                      },
                      child: Container(
                        width: 70,
                        color: corRoxoMedio,
                        alignment: Alignment.center,
                        child: Icon(Icons.delete, color: corClara, size: 30,),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // deletando
  //             ? GestureDetector(
  //                   onTap: () {
  //                     setState(() {
  //                       professores.remove(professor);
  //                       professoresFiltrados.remove(professor);
  //                     });
  //                     DataService.removerProfessor(professor);
  //                   },
  //                   child: Container(
  //                     color: corRoxoMedio,
  //                     child: ListTile(
  //                       contentPadding: EdgeInsets.symmetric(
  //                         vertical: 5,
  //                         horizontal: 10,
  //                       ),
  //                       title: Text(professor['nome'] ?? '', style: bold),
  //                       trailing: Icon(Icons.delete, color: corClara),
  //                     ),
  //                   ),
  //                 )

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
                    suffixIcon: IconButton(
                      icon: Image.asset('assets/images/lupa.png'),
                      onPressed: _buscar,
                    ),
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
