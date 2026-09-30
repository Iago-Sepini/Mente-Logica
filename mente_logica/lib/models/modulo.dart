import 'pergunta_quiz.dart';

class Aula {
  final String titulo;
  final String textoExplicativo;
  final String? urlImagem; // diagrama/esquema
  final String? urlVideo;  // vídeo demonstrativo

  const Aula({
    required this.titulo,
    required this.textoExplicativo,
    this.urlImagem,
    this.urlVideo,
  });
}

class Modulo {
  final int numero;
  final String titulo;
  final String iconePath;
  final List<Aula> aulas;
  final List<PerguntaQuiz> quiz;
  bool concluido;

  Modulo({
    required this.numero,
    required this.titulo,
    required this.iconePath,
    required this.aulas,
    required this.quiz,
    this.concluido = false,
  });
}