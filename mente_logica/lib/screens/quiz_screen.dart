import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/conquistas_data.dart';
import '../models/modulo.dart';
import '../providers/progresso_provider.dart';
import '../widgets/conquista_dialog.dart';

class QuizScreen extends StatefulWidget {
  final Modulo modulo;

  const QuizScreen({super.key, required this.modulo});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _perguntaAtual = 0;
  int _acertos = 0;
  int? _opcaoSelecionada;
  bool _respondeu = false;
  bool _finalizado = false;

  int _sequenciaAtual = 0;
  int _maiorSequencia = 0;

  void _responder(int index) {
    if (_respondeu) return;

    final pergunta = widget.modulo.quiz[_perguntaAtual];
    final correta = index == pergunta.respostaCorretaIndex;

    setState(() {
      _opcaoSelecionada = index;
      _respondeu = true;
      if (correta) {
        _acertos++;
        _sequenciaAtual++;
        if (_sequenciaAtual > _maiorSequencia) _maiorSequencia = _sequenciaAtual;
      } else {
        _sequenciaAtual = 0;
      }
    });
  }

  Future<void> _proxima() async {
    final ultima = _perguntaAtual == widget.modulo.quiz.length - 1;

    if (ultima) {
      await _finalizarQuiz();
    } else {
      setState(() {
        _perguntaAtual++;
        _opcaoSelecionada = null;
        _respondeu = false;
      });
    }
  }

  Future<void> _finalizarQuiz() async {
    final progresso = context.read<ProgressoProvider>();
    final total = widget.modulo.quiz.length;
    final acertouTudo = _acertos == total;

    final xpGanho = _acertos * 10 + (acertouTudo ? 30 : 0);
    await progresso.adicionarXp(xpGanho);
    await progresso.marcarConcluido(widget.modulo.numero);

    final novasConquistas = <String>[];

    if (_maiorSequencia >= 3 && await progresso.desbloquearConquista('sequencia_3')) {
      novasConquistas.add('sequencia_3');
    }
    if (acertouTudo && await progresso.desbloquearConquista('perfeccionista')) {
      novasConquistas.add('perfeccionista');
    }

    if (!mounted) return;
    setState(() => _finalizado = true);

    for (final id in novasConquistas) {
      if (!mounted) return;
      final conquista = todasConquistas.firstWhere((c) => c.id == id);
      await mostrarConquistaDesbloqueada(context, conquista);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_finalizado) {
      return _buildResultado(context);
    }

    final pergunta = widget.modulo.quiz[_perguntaAtual];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz — Módulo ${widget.modulo.numero}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pergunta ${_perguntaAtual + 1} de ${widget.modulo.quiz.length}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Text(
              pergunta.pergunta,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: pergunta.opcoes.length,
                itemBuilder: (context, index) {
                  final selecionada = _opcaoSelecionada == index;
                  final correta = index == pergunta.respostaCorretaIndex;

                  Color? corFundo;
                  IconData? icone;

                  if (_respondeu) {
                    if (correta) {
                      corFundo = Colors.green.shade100;
                      icone = Icons.check_circle;
                    } else if (selecionada && !correta) {
                      corFundo = Colors.red.shade100;
                      icone = Icons.cancel;
                    }
                  }

                  return Card(
                    color: corFundo,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: selecionada
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: ListTile(
                      onTap: () => _responder(index),
                      title: Text(pergunta.opcoes[index]),
                      trailing: icone != null
                          ? Icon(icone, color: correta ? Colors.green : Colors.red)
                          : null,
                    ),
                  );
                },
              ),
            ),
            if (_respondeu)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _proxima,
                  child: Text(
                    _perguntaAtual == widget.modulo.quiz.length - 1
                        ? 'Ver resultado'
                        : 'Próxima pergunta',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultado(BuildContext context) {
    final total = widget.modulo.quiz.length;
    final percentual = (_acertos / total * 100).round();
    final xpGanho = _acertos * 10 + (_acertos == total ? 30 : 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                percentual >= 70 ? Icons.emoji_events : Icons.school,
                size: 80,
                color: percentual >= 70 ? Colors.amber : Colors.blueGrey,
              ),
              const SizedBox(height: 16),
              Text(
                'Você acertou $_acertos de $total ($percentual%)',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '+$xpGanho XP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                percentual >= 70
                    ? 'Mandou muito bem! Módulo concluído. 🎉'
                    : 'Quase lá! Que tal revisar a teoria e tentar de novo?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Voltar para os módulos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}