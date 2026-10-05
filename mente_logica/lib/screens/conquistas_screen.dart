import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/conquistas_data.dart';
import '../providers/progresso_provider.dart';

class ConquistasScreen extends StatelessWidget {
  const ConquistasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progresso = context.watch<ProgressoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Conquistas')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: todasConquistas.length,
        itemBuilder: (context, index) {
          final conquista = todasConquistas[index];
          final desbloqueada = progresso.conquistasDesbloqueadas.contains(conquista.id);

          return Card(
            elevation: desbloqueada ? 3 : 0,
            color: desbloqueada ? Colors.amber.shade50 : Colors.grey.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: desbloqueada ? 1 : 0.3,
                    child: Text(conquista.emoji, style: const TextStyle(fontSize: 40)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    conquista.titulo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: desbloqueada ? Colors.black87 : Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conquista.descricao,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  if (!desbloqueada) ...[
                    const SizedBox(height: 6),
                    Icon(Icons.lock, size: 16, color: Colors.grey.shade400),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}