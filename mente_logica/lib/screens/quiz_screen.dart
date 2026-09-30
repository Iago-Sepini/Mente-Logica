import 'package:flutter/material.dart';
import '../models/modulo.dart';
import 'package:provider/provider.dart';
import '../providers/progresso_provider.dart';

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

  void _responder(int index) {
    if (_respondeu) return;

    final pergunta = widget.modulo.quiz[_perguntaAtual];
    final correta = index == pergunta.respostaCorretaIndex;

    setState(() {
      _opcaoSelecionada = index;
      _respondeu = true;
      if (correta) _acertos++;
    });
  }

  void _proxima() {
  final ultima = _perguntaAtual == widget.modulo.quiz.length - 1;

  if (ultima) {
    context.read<ProgressoProvider>().marcarConcluido(widget.modulo.numero);
    setState(() => _finalizado = true);
  } else {
    setState(() {
      _perguntaAtual++;
      _opcaoSelecionada = null;
      _respondeu = false;
    });
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
                          ? Icon(icone,
                              color: correta ? Colors.green : Colors.red)
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