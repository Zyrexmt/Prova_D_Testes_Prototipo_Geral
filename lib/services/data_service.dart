import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static List<Map<String, dynamic>> cursos = [];
  static List<Map<String, dynamic>> professores = [];
  static List<Map<String, dynamic>> categorias = [];

  static const _keyCursos = 'cursos';
  static const _keyProfessores = 'professores_id';

  static Future<void> carregar() async {
    final String jsonString = await rootBundle.loadString(
      'assets/jsons/dados.json',
    );
    final Map<String, dynamic> data = jsonDecode(jsonString);

    categorias = _parseList(data['categorias']);

    final prefs = await SharedPreferences.getInstance();

    final savedCursos = prefs.getString(_keyCursos);
    if (savedCursos != null) {
      cursos = _parseList(jsonDecode(savedCursos));
    } else {
      cursos = _parseList(data['cursos']);
      await _salvarCursos(prefs);
    }

    final savedProfessores = prefs.getString(_keyProfessores);
    if (savedProfessores != null) {
      professores = _parseList(jsonDecode(savedProfessores));
    } else {
      professores = _parseList(data['professores_id']);
      await _salvarProfessores(prefs);
    }
  }

  static List<Map<String, dynamic>> _parseList(dynamic list) {
    return List<Map<String, dynamic>>.from(
      (list as List).map((e) => Map<String, dynamic>.from(e as Map)),
    );
  }

  static Future<void> _salvarCursos([
    SharedPreferences? prefs,
  ]) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs.setString(_keyCursos, jsonEncode(cursos));
  }

  static Future<void> adicionarCurso(
    Map<String, dynamic> novoCurso,
  ) async {
    cursos.add(novoCurso);
    await _salvarCursos();
  }

  static Future<void> _salvarProfessores([
    SharedPreferences? prefs,
  ]) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs.setString(_keyProfessores, jsonEncode(professores));
  }

  static Future<void> adicionarProfessor(
    Map<String, dynamic> novoProfessor,
  ) async {
    professores.add(novoProfessor);
    _salvarProfessores();
  }

  static Future<void> removerProfessor(
    Map<String, dynamic> professor,
  ) async {
    professores.remove(professor);
    _salvarProfessores();
  }

  static List<Map<String, dynamic>> getProfessoresDoCurso(
    Map<String, dynamic> curso,
  ) {
    final ids = List<int>.from(curso['professores_id'] ?? []);
    return professores.where((p) => ids.contains(p['id'])).toList();
  }

  static Future<void> resetarParaJson() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCursos);
    await carregar();
  }
}
