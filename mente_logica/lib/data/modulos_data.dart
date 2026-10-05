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
      PerguntaQuiz(
        pergunta: 'Qual área de conhecimento NÃO faz parte da robótica?',
        opcoes: ['Eletrônica', 'Mecânica', 'Programação', 'Culinária'],
        respostaCorretaIndex: 3,
      ),
      PerguntaQuiz(
        pergunta: 'Como o código é transferido do computador para o Arduino?',
        opcoes: [
          'Por Bluetooth automaticamente',
          'Por um cabo USB, usando a IDE do Arduino',
          'Escrevendo diretamente na placa',
          'Não é possível transferir código',
        ],
        respostaCorretaIndex: 1,
      ),
      PerguntaQuiz(
        pergunta: 'Qual é a principal vantagem de usar uma placa como o Arduino em projetos de robótica?',
        opcoes: [
          'Ela substitui o computador por completo',
          'Ela permite ler sensores e controlar componentes com poucas linhas de código',
          'Ela não precisa de programação',
          'Ela só funciona com peças da própria marca',
        ],
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
      PerguntaQuiz(
        pergunta: 'O que é uma variável em programação?',
        opcoes: [
          'Um tipo de sensor',
          'Um espaço para guardar informações que podem mudar',
          'Um comando que liga o Arduino',
          'Um componente eletrônico',
        ],
        respostaCorretaIndex: 1,
      ),
      PerguntaQuiz(
        pergunta: 'Quando usamos uma estrutura "if/else" no código?',
        opcoes: [
          'Quando queremos repetir uma ação várias vezes',
          'Quando queremos guardar um valor fixo',
          'Quando o código precisa tomar uma decisão entre duas opções',
          'Quando queremos desligar o Arduino',
        ],
        respostaCorretaIndex: 2,
      ),
      PerguntaQuiz(
        pergunta: 'Qual a diferença principal entre um laço "for" e um "while"?',
        opcoes: [
          'Não existe diferença, são a mesma coisa',
          'O "for" é usado quando já se sabe quantas vezes repetir, o "while" repete enquanto uma condição for verdadeira',
          'O "while" só funciona com números negativos',
          'O "for" só pode ser usado uma vez por programa',
        ],
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
      PerguntaQuiz(
        pergunta: 'O que acontece se um LED for ligado sem resistor?',
        opcoes: [
          'Nada, ele funciona normalmente',
          'Ele pode queimar por excesso de corrente',
          'Ele fica mais brilhante e dura mais',
          'Ele muda de cor',
        ],
        respostaCorretaIndex: 1,
      ),
      PerguntaQuiz(
        pergunta: 'Um sensor de presença (PIR) detecta o quê?',
        opcoes: ['Som', 'Luminosidade', 'Movimento/calor de pessoas ou animais', 'Umidade do ar'],
        respostaCorretaIndex: 2,
      ),
      PerguntaQuiz(
        pergunta: 'Qual componente é usado para medir a temperatura do ambiente em um projeto Arduino?',
        opcoes: ['Resistor', 'LED', 'Sensor de temperatura', 'Botão'],
        respostaCorretaIndex: 2,
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
      PerguntaQuiz(
        pergunta: 'Para que serve a função setup()?',
        opcoes: [
          'Para rodar o código em loop infinito',
          'Para configurar algo que só precisa rodar uma vez, como definir pinos',
          'Para ler sensores continuamente',
          'Ela não existe no Arduino',
        ],
        respostaCorretaIndex: 1,
      ),
      PerguntaQuiz(
        pergunta: 'Qual comando é usado para ligar ou desligar um LED em um pino digital?',
        opcoes: ['analogRead()', 'digitalWrite()', 'delay()', 'Serial.print()'],
        respostaCorretaIndex: 1,
      ),
      PerguntaQuiz(
        pergunta: 'Qual a diferença entre leitura digital e leitura analógica?',
        opcoes: [
          'Não existe diferença',
          'A digital só identifica dois estados (ligado/desligado), a analógica lê uma faixa de valores',
          'A analógica só funciona com LEDs',
          'A digital é mais lenta que a analógica',
        ],
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
      PerguntaQuiz(
        pergunta: 'No projeto Pisca-Pisca, qual função cria o intervalo entre ligar e desligar o LED?',
        opcoes: ['digitalWrite()', 'delay()', 'pinMode()', 'analogWrite()'],
        respostaCorretaIndex: 1,
      ),
      PerguntaQuiz(
        pergunta: 'Quantos LEDs são usados no projeto do Semáforo Inteligente?',
        opcoes: ['1', '2', '3', '4'],
        respostaCorretaIndex: 2,
      ),
      PerguntaQuiz(
        pergunta: 'No projeto de alarme, o que normalmente é acionado quando o sensor PIR detecta movimento?',
        opcoes: [
          'Um buzzer ou LED de alerta',
          'O Arduino desliga sozinho',
          'Um motor DC gira indefinidamente',
          'Nada acontece sem um botão',
        ],
        respostaCorretaIndex: 0,
      ),
    ],
  ),
];