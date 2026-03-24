import 'package:flutter/material.dart';
import 'package:teste/global/variaveis.dart';

class ProfessorCreate extends StatefulWidget {
  const ProfessorCreate({super.key});

  @override
  State<ProfessorCreate> createState() => _ProfessorCreateState();
}

class _ProfessorCreateState extends State<ProfessorCreate> {
  String nome = '',
      email = '',
      telefone = '',
      descricao = '',
      imagem = '';
  TextEditingController nomeController = TextEditingController(),
      emailController = TextEditingController(),
      telefoneController = TextEditingController(),
      descricaoController = TextEditingController(),
      imagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 30),
            Text('Professores - Novo', style: black),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(2),
                child: Text('Nome', style: regular),
              ),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal()
                  ),
                  fillColor: corClara,
                  filled: true
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                margin: EdgeInsets.all(2),
                child: Text('E-mail', style: regular),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal()
                  ),
                  fillColor: corClara,
                  filled: true
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                margin: EdgeInsets.all(2),
                child: Text('Telefone', style: regular),
              ),
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal()
                  ),
                  fillColor: corClara,
                  filled: true
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(2),
                child: Text('Descrição', style: regular),
              ),
              TextField(
                controller: descricaoController,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal()
                  ),
                  fillColor: corClara,
                  filled: true
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                margin: EdgeInsets.all(2),
                child: Text('Imagem', style: regular),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[ 

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
                        ).pushReplacementNamed('/teachers');
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
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
