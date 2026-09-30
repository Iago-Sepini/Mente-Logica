import '../models/modulo.dart';
import '../models/pergunta_quiz.dart';

final List<Modulo> modulosMenteLogica = [
  Modulo(
    numero: 1,
    titulo: 'Introdução à Robótica & Arduino',
    iconePath: 'assets/icons/modulo_1.svg',
    aulas: const [
      Aula(
        titulo: 'O que é robótica?',
        textoExplicativo:
            'Robótica é a área que une eletrônica, mecânica e programação '
            'para criar máquinas capazes de interagir com o mundo real.',
      ),
      Aula(
        titulo: 'Apresentando a placa Arduino UNO',
        textoExplicativo:
            'O Arduino UNO é uma placa de prototipagem eletrônica que permite '
            'ler sensores e controlar componentes através de código.',
      ),
    ],
    quiz: const [
      PerguntaQuiz(
        pergunta: 'O que é o Arduino UNO?',
        opcoes: ['Um sensor', 'Uma placa de prototipagem', 'Um tipo de motor', 'Um software'],
        respostaCorretaIndex: 1,
      ),
    ],
  ),
  Modulo(
    numero: 2,
    titulo: 'Lógica de Programação Descomplicada',
    iconePath: 'assets/icons/modulo_2.svg',
    aulas: const [
      Aula(
        titulo: 'Variáveis e Estruturas Condicionais (if/else)',
        textoExplicativo:
            'Variáveis guardam informações. Estruturas condicionais (if/else) '
            'permitem que o código tome decisões diferentes conforme a situação.',
      ),
      Aula(
        titulo: 'Laços de Repetição (for/while)',
        textoExplicativo:
            'Laços de repetição executam um bloco de código várias vezes, '
            'evitando que você escreva a mesma coisa repetidamente.',
      ),
    ],
    quiz: const [
      PerguntaQuiz(
        pergunta: 'Para que serve um laço de repetição?',
        opcoes: ['Guardar dados', 'Repetir um bloco de código', 'Ligar um LED', 'Medir temperatura'],
        respostaCorretaIndex: 1,
      ),
    ],
  ),
  Modulo(
    numero: 3,
    titulo: 'Componentes Eletrônicos Básicos',
    iconePath: 'assets/icons/modulo_3.svg',
    aulas: const [
      Aula(
        titulo: 'LEDs e Resistores (Lei de Ohm simplificada)',
        textoExplicativo:
            'LEDs emitem luz quando a corrente passa por eles. Resistores '
            'controlam essa corrente para não queimar o componente.',
      ),
      Aula(
        titulo: 'Sensores (Luz, Temperatura e Presença)',
        textoExplicativo:
            'Sensores captam informações do ambiente, como luminosidade, '
            'temperatura ou presença, e enviam esses dados para o Arduino.',
      ),
    ],
    quiz: const [
      PerguntaQuiz(
        pergunta: 'Qual a função de um resistor com um LED?',
        opcoes: ['Aumentar a luz', 'Controlar a corrente', 'Guardar energia', 'Emitir som'],
        respostaCorretaIndex: 1,
      ),
    ],
  ),
  Modulo(
    numero: 4,
    titulo: 'Programação Prática com Arduino',
    iconePath: 'assets/icons/modulo_4.svg',
    aulas: const [
      Aula(
        titulo: 'Estrutura de Código (setup e loop)',
        textoExplicativo:
            'Todo programa Arduino tem duas funções principais: setup(), que '
            'roda uma vez, e loop(), que roda continuamente.',
      ),
      Aula(
        titulo: 'Leitura e Escrita Digital/Analógica',
        textoExplicativo:
            'O Arduino pode ler sinais (digitais ou analógicos) de sensores '
            'e escrever sinais para controlar LEDs, motores e outros atuadores.',
      ),
    ],
    quiz: const [
      PerguntaQuiz(
        pergunta: 'Qual função roda continuamente no Arduino?',
        opcoes: ['setup()', 'loop()', 'main()', 'start()'],
        respostaCorretaIndex: 1,
      ),
    ],
  ),
  Modulo(
    numero: 5,
    titulo: 'Projetos Práticos Passo a Passo',
    iconePath: 'assets/icons/modulo_5.svg',
    aulas: const [
      Aula(
        titulo: 'Pisca-Pisca (Blink LED)',
        textoExplicativo:
            'O projeto mais clássico: fazer um LED piscar usando digitalWrite() '
            'e delay().',
      ),
      Aula(
        titulo: 'Semáforo Inteligente',
        textoExplicativo:
            'Combine três LEDs (vermelho, amarelo e verde) para simular o '
            'funcionamento de um semáforo real.',
      ),
      Aula(
        titulo: 'Alarme com Sensor de Presença',
        textoExplicativo:
            'Use um sensor PIR para detectar movimento e acionar um alarme '
            'sonoro ou visual.',
      ),
    ],
    quiz: const [
      PerguntaQuiz(
        pergunta: 'Qual componente detecta movimento no projeto de alarme?',
        opcoes: ['LED', 'Resistor', 'Sensor PIR', 'Buzzer'],
        respostaCorretaIndex: 2,
      ),
    ],
  ),
];