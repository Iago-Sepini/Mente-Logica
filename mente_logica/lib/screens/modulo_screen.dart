import 'package:flutter/material.dart';
import '../models/modulo.dart';
import 'quiz_screen.dart';

class ModuloScreen extends StatefulWidget {
  final Modulo modulo;

  const ModuloScreen({super.key, required this.modulo});

  @override
  State<ModuloScreen> createState() => _ModuloScreenState();
}

class _ModuloScreenState extends State<ModuloScreen> {
  final PageController _controller = PageController();
  int _aulaAtual = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _proximaAula() {
    if (_aulaAtual < widget.modulo.aulas.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // última aula: vai para o quiz
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => QuizScreen(modulo: widget.modulo),
        ),
      );
    }
  }

  void _aulaAnterior() {
    if (_aulaAtual > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final aulas = widget.modulo.aulas;
    final ultimaAula = _aulaAtual == aulas.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo ${widget.modulo.numero}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: List.generate(aulas.length, (i) {
                final ativo = i <= _aulaAtual;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    decoration: BoxDecoration(
                      color: ativo
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: aulas.length,
              onPageChanged: (i) => setState(() => _aulaAtual = i),
              itemBuilder: (context, index) {
                final aula = aulas[index];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aula.titulo,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (aula.urlImagem != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(aula.urlImagem!),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        aula.textoExplicativo,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      if (aula.urlVideo != null) ...[
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {
                            // TODO: abrir vídeo (ex: com url_launcher ou video_player)
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text('Assistir vídeo demonstrativo'),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_aulaAtual > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _aulaAnterior,
                      child: const Text('Anterior'),
                    ),
                  ),
                if (_aulaAtual > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: _proximaAula,
                    child: Text(ultimaAula ? 'Ir para o Quiz' : 'Próxima aula'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}