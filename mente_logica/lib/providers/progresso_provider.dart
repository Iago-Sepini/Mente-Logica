import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/modulos_data.dart';

class ProgressoProvider extends ChangeNotifier {
  static const _prefixoChave = 'modulo_concluido_';

  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    for (final modulo in modulosMenteLogica) {
      modulo.concluido = prefs.getBool('$_prefixoChave${modulo.numero}') ?? false;
    }
    notifyListeners();
  }

  Future<void> marcarConcluido(int numeroModulo) async {
    final modulo = modulosMenteLogica.firstWhere((m) => m.numero == numeroModulo);
    modulo.concluido = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefixoChave$numeroModulo', true);

    notifyListeners();
  }

  Future<void> resetarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    for (final modulo in modulosMenteLogica) {
      modulo.concluido = false;
      await prefs.remove('$_prefixoChave${modulo.numero}');
    }
    notifyListeners();
  }

  int get totalConcluidos =>
      modulosMenteLogica.where((m) => m.concluido).length;

  double get percentualProgresso =>
      totalConcluidos / modulosMenteLogica.length;
}