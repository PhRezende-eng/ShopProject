// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

double calculaMedia(double nota1, double nota2, double notaOp) {
  return ((nota1 + nota2 + notaOp) / 3);
}

void calculaOptativa(double nota1, double nota2, double notaOp) {
  if (nota1 < nota2) {
    nota1 = notaOp;
  } else {
    nota2 = notaOp;
  }
}

void calculaResultado(double nota1, double nota2, double notaOp) {
  double media = calculaMedia(nota1, nota2, notaOp);
  if (media >= 6) {
    print('Aprovado');
  } else if (media < 3) {
    print('Reprovado');
  } else {
    print('Exame');
  }
}

double calculaOp0(double notaOp) {
  if (notaOp == 0) {
    return -1;
  }
  return notaOp;
}

main() {
  double notaAvaliacao1 = double.parse(stdin.readLineSync()!);
  double notaAvaliacao2 = double.parse(stdin.readLineSync()!);
  double notaAvaliacaoOptativa = double.parse(stdin.readLineSync()!);

  notaAvaliacaoOptativa = calculaOp0(notaAvaliacaoOptativa);

  calculaOptativa(notaAvaliacao1, notaAvaliacao2, notaAvaliacaoOptativa);

  calculaResultado(notaAvaliacao1, notaAvaliacao2, notaAvaliacaoOptativa);
}
