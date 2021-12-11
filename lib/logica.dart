// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

main() {
  int notaAvaliacao1 = 0;
  int notaAvaliacao2 = 0;
  int notaAvaliacaoOptativa = 0;

  notaAvaliacao1 = int.parse(stdin.readLineSync()!);
  notaAvaliacao2 = int.parse(stdin.readLineSync()!);
  notaAvaliacaoOptativa = int.parse(stdin.readLineSync()!);

  print(notaAvaliacao1.runtimeType);
  print(notaAvaliacao2);
  print(notaAvaliacaoOptativa);
}
