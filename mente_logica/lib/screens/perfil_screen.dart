import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/conquistas_data.dart';
import '../providers/progresso_provider.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progresso = context.watch<ProgressoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: const Text('🧑‍💻', style: TextStyle(fontSize: 36)),
                ),
                const SizedBox(height: 12),
                Text(
                  'Nível ${progresso.nivel}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progresso.progressoNivel,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${progresso.xp} XP · faltam ${progresso.xpParaProximoNivel} XP para o próximo nível',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _EstatisticaCard(
                  titulo: 'Módulos',
                  valor: '${progresso.totalConcluidos}/5',
                  icone: Icons.menu_book,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _EstatisticaCard(
                  titulo: 'Conquistas',
                  valor: '${progresso.conquistasDesbloqueadas.length}/${todasConquistas.length}',
                  icone: Icons.emoji_events,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            onPressed: () => _confirmarReset(context),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reiniciar progresso'),
          ),
        ],
      ),
    );
  }

  void _confirmarReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reiniciar progresso?'),
        content: const Text('Isso vai apagar seu XP, conquistas e módulos concluídos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ProgressoProvider>().resetarProgresso();
              Navigator.of(context).pop();
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }
}

class _EstatisticaCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icone;

  const _EstatisticaCard({
    required this.titulo,
    required this.valor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icone, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(valor, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(titulo, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}