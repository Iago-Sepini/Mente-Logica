class PerguntaQuiz {
  final String pergunta;
  final List<String> opcoes;
  final int respostaCorretaIndex;

  const PerguntaQuiz({
    required this.pergunta,
    required this.opcoes,
    required this.respostaCorretaIndex,
  });
}