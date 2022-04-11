// ignore_for_file: avoid_print

forWithoutInt() {
  String str = '#';
  while (str != '##############') {
    print(str);
    str += '#';
  }

  for (String char = ''; char != '##############'; char += '#') {
    print(char);
  }
}

void main() {
  forWithoutInt();
}
