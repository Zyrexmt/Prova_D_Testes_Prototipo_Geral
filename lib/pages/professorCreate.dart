import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:teste/global/variaveis.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste/services/data_service.dart';

class ProfessorCreate extends StatefulWidget {
  const ProfessorCreate({super.key});

  @override
  State<ProfessorCreate> createState() => _ProfessorCreateState();
}

class _ProfessorCreateState extends State<ProfessorCreate> {
  File? imagemSelecionada;
  TextEditingController nomeController = TextEditingController(),
      emailController = TextEditingController(),
      descricaoController = TextEditingController(),
      imagemController = TextEditingController();
  MaskedTextController telefoneController = MaskedTextController(
    mask: '(00) 00000-0000',
  );

  void _salvar() async {
    final novoProfessor = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'nome': nomeController.text,
      'email': emailController.text,
      'telefone': telefoneController.text,
      'descricao': descricaoController.text,
    };
    if (nomeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Nome é obrigatório')));
      return;
    }
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email é obrigatório')));
      return;
    }
    if (telefoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Telefone é obrigatório')),
      );
      return;
    }
    if (descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Descrição é obrigatório')),
      );
      return;
    }
    if (!emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formato inválido do E-mail')),
      );
      return;
    }
    await DataService.adicionarProfessor(novoProfessor);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/teachers');
    }
  }

  Widget _campoImagem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: imagemSelecionada == null ? _selecionarImagem : null,
          child: Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              border: Border.all(color: corEscuro),
            ),
            child: imagemSelecionada != null
                ? Stack(
                    children: [
                      InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.file(
                          imagemSelecionada!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => setState(
                            () => imagemSelecionada = null,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: corClara,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: corRoxoEscuro,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _selecionarImagem() async {
    final imagem = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagem != null) {
      setState(() => imagemSelecionada = File(imagem.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome', style: regular),
                      SizedBox(height: 4),
                      TextField(
                        maxLength: 60,
                        controller: nomeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                          fillColor: corClara,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 10),

                      Text('E-mail', style: regular),
                      SizedBox(height: 4),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                          fillColor: corClara,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 10),

                      Text('Telefone', style: regular),
                      SizedBox(height: 4),
                      TextField(
                        controller: telefoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                          fillColor: corClara,
                          filled: true,
                          hintText: '(99) 99999-9999',
                        ),
                      ),
                      SizedBox(height: 10),

                      Text('Descrição', style: regular),
                      SizedBox(height: 4),
                      TextField(
                        controller: descricaoController,
                        minLines: 3,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                          fillColor: corClara,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 10),

                      Text('Imagem', style: regular),
                      SizedBox(height: 8),
                      _campoImagem(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // botões fixos em baixo, fora do scroll
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
                    onPressed: () => Navigator.of(
                      context,
                    ).pushReplacementNamed('/teachers'),
                    style: TextButton.styleFrom(
                      backgroundColor: corRoxoEscuro,
                      foregroundColor: corClara,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadiusGeometry.horizontal(),
                      ),
                      fixedSize: Size(70, 40),
                    ),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
