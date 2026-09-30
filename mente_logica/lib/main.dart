import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'providers/progresso_provider.dart';
import 'screens/splash.dart';

void main() {
  runApp(const MenteLogicaApp());
}

class MenteLogicaApp extends StatelessWidget {
  const MenteLogicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProgressoProvider()..carregarProgresso(),
      child: MaterialApp(
        title: 'Mente Lógica',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1A237E),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}