import 'dart:math' as math;

int get6DigitsCode() {
  var rnd = math.Random();
  var next = rnd.nextDouble() * 1000000;
  while (next < 100000) {
    next *= 10;
  }
  return next.toInt();
}
