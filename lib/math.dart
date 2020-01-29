import 'dart:math';

getFractions(List<Point> line) {
  List<num> fractions = [0];
  for (int i = 0; i < line.length - 1; i++) {
    fractions.add(fractions.last + line[i].distanceTo(line[i + 1]));
  }
  // if the line is made of the same point
  if (fractions.last == 0) fractions.last = 1;

  return [for (var value in fractions) value / fractions.last];
}

Point interpolatePoint(num x, List<num> xs, List<Point> line) {
  assert(x >= xs.first);
  assert(x <= xs.last);
  if (x == xs.first) return line.first;
  if (x == xs.last) return line.last;

  //  find limits
  int stop;
  for (stop = 1; stop < xs.length; stop++) {
    if (x < xs[stop]) break;
  }
  int start = stop - 1;
  assert(xs[stop] != xs[start]);
  num lambda = (x - xs[start]) / (xs[stop] - xs[start]);
  return pointAlong(line[start], line[stop], lambda);
}

interpolateAlongAxis(
    List<num> target_fractions, List<num> current_fractions, List<Point> line) {
  return [
    for (var fraction in target_fractions)
      interpolatePoint(fraction, current_fractions, line)
  ];
}

pointAlong(Point start, Point stop, num t) {
  return start + (stop - start) * t;
}
