import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/modulos_data.dart';
import '../providers/progresso_provider.dart';
import '../widgets/modulo_card.dart';
import 'modulo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progresso = context.watch<ProgressoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mente Lógica'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Reiniciar progresso',
            icon: const Icon(Icons.restart_alt),
            onPressed: () => context.read<ProgressoProvider>().resetarProgresso(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seu progresso',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progresso.percentualProgresso,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${progresso.totalConcluidos} de ${modulosMenteLogica.length} módulos concluídos',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: modulosMenteLogica.length,
              itemBuilder: (context, index) {
                final modulo = modulosMenteLogica[index];
                return ModuloCard(
                  modulo: modulo,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ModuloScreen(modulo: modulo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}