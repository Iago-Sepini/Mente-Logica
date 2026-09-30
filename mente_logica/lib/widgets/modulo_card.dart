import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/modulo.dart';

class ModuloCard extends StatelessWidget {
  final Modulo modulo;
  final VoidCallback onTap;

  const ModuloCard({
    super.key,
    required this.modulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: modulo.concluido
                    ? Colors.green.shade100
                    : Theme.of(context).colorScheme.primaryContainer,
                child: SvgPicture.asset(
                  modulo.iconePath,
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    modulo.concluido
                        ? Colors.green.shade700
                        : Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Módulo ${modulo.numero}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      modulo.titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${modulo.aulas.length} aulas · ${modulo.quiz.length} pergunta(s)',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              if (modulo.concluido)
                const Icon(Icons.check_circle, color: Colors.green)
              else
                const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}