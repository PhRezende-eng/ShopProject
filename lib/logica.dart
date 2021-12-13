// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

double calculaOp0(double notaOp) {
  if (notaOp == 0) {
    return -1;
  }
  return notaOp;
}

void calculaOptativa(double nota1, double nota2, double notaOp) {
  if (nota1 < nota2) {
    nota1 = nota1 > notaOp ? nota1 : notaOp;
  } else {
    nota2 = nota2 > notaOp ? nota2 : notaOp;
  }
}

double calculaMedia(double nota1, double nota2) {
  return ((nota1 + nota2) / 2);
}

void calculaResultado(double nota1, double nota2, double notaOp) {
  double media = calculaMedia(nota1, nota2) + notaOp * 0.2;
  if (media >= 6) {
    print('Aprovado');
  } else if (media < 3) {
    print('Reprovado');
  } else {
    print('Exame');
  }
}

main() {
  double notaAvaliacao1 = double.parse(stdin.readLineSync()!);
  double notaAvaliacao2 = double.parse(stdin.readLineSync()!);
  double notaAvaliacaoOptativa = double.parse(stdin.readLineSync()!);

  notaAvaliacaoOptativa = calculaOp0(notaAvaliacaoOptativa);

  calculaOptativa(notaAvaliacao1, notaAvaliacao2, notaAvaliacaoOptativa);

  calculaResultado(notaAvaliacao1, notaAvaliacao2, notaAvaliacaoOptativa);
}
