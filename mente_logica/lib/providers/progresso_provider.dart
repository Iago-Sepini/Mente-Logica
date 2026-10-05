import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/modulos_data.dart';

class ProgressoProvider extends ChangeNotifier {
  static const _prefixoModulo = 'modulo_concluido_';
  static const _chaveXp = 'xp_total';
  static const _chaveConquistas = 'conquistas_desbloqueadas';
  static const _chaveDiasAcessados = 'dias_acessados';

  int xp = 0;
  Set<String> conquistasDesbloqueadas = {};
  Set<String> diasAcessados = {};

  int get nivel => (xp / 100).floor() + 1;
  double get progressoNivel => (xp % 100) / 100;
  int get xpParaProximoNivel => 100 - (xp % 100);

  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    for (final modulo in modulosMenteLogica) {
      modulo.concluido = prefs.getBool('$_prefixoModulo${modulo.numero}') ?? false;
    }
    xp = prefs.getInt(_chaveXp) ?? 0;
    conquistasDesbloqueadas = (prefs.getStringList(_chaveConquistas) ?? []).toSet();
    diasAcessados = (prefs.getStringList(_chaveDiasAcessados) ?? []).toSet();

    await _registrarAcessoHoje();
    notifyListeners();
  }

  Future<void> _registrarAcessoHoje() async {
    final hoje = DateTime.now();
    final chaveDia = '${hoje.year}-${hoje.month}-${hoje.day}';
    if (!diasAcessados.contains(chaveDia)) {
      diasAcessados.add(chaveDia);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_chaveDiasAcessados, diasAcessados.toList());
      if (diasAcessados.length >= 3) {
        await desbloquearConquista('dedicado');
      }
    }
  }

  Future<void> adicionarXp(int quantidade) async {
    xp += quantidade;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_chaveXp, xp);
    notifyListeners();
  }

  Future<void> marcarConcluido(int numeroModulo) async {
    final modulo = modulosMenteLogica.firstWhere((m) => m.numero == numeroModulo);
    modulo.concluido = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefixoModulo$numeroModulo', true);

    if (modulosMenteLogica.where((m) => m.concluido).length == 1) {
      await desbloquearConquista('primeiro_modulo');
    }
    if (modulosMenteLogica.every((m) => m.concluido)) {
      await desbloquearConquista('maratonista');
    }

    notifyListeners();
  }

  /// Retorna true se a conquista foi desbloqueada agora (ainda não tinha sido).
  Future<bool> desbloquearConquista(String id) async {
    if (conquistasDesbloqueadas.contains(id)) return false;

    conquistasDesbloqueadas.add(id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_chaveConquistas, conquistasDesbloqueadas.toList());
    notifyListeners();
    return true;
  }

  Future<void> resetarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    for (final modulo in modulosMenteLogica) {
      modulo.concluido = false;
      await prefs.remove('$_prefixoModulo${modulo.numero}');
    }
    xp = 0;
    conquistasDesbloqueadas.clear();
    diasAcessados.clear();
    await prefs.remove(_chaveXp);
    await prefs.remove(_chaveConquistas);
    await prefs.remove(_chaveDiasAcessados);
    notifyListeners();
  }

  int get totalConcluidos => modulosMenteLogica.where((m) => m.concluido).length;
  double get percentualProgresso => totalConcluidos / modulosMenteLogica.length;
}