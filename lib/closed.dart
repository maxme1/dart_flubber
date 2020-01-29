import 'dart:math';
import 'math.dart' as math;

prepare(List<Point> start, List<Point> stop) {
  start = normalize(start);
  stop = normalize(stop);

  int diff = start.length - stop.length;
  if (diff < 0) {
    start = addPoints(start, -diff);
  } else if (diff > 0) {
    stop = addPoints(stop, diff);
  }

  start = rotate(start, stop);
  return [start, stop];
}

num getArea(List<Point> contour) {
  num area = 0;
  for (var i = 0; i < contour.length; i++) {
    var a = contour[i], b = contour[(i + 1) % contour.length];
    area += a.y * b.x - a.x * b.y;
  }
  return area / 2;
}

normalize(List<Point> line) {
  if (getArea(line) > 0) {
    line = line.reversed.toList();
  }
  return line;
}

rotate(List<Point> line, List<Point> reference) {
  var len = line.length, min = double.infinity, bestOffset = 0;

  for (var offset = 0; offset < len; offset++) {
    num sumOfSquares = 0;

    for (var i = 0; i < line.length; i++) {
      sumOfSquares += line[(offset + i) % len].squaredDistanceTo(reference[i]);
    }

    if (sumOfSquares < min) {
      min = sumOfSquares;
      bestOffset = offset;
    }
  }

  if (bestOffset != 0) {
    line = line.sublist(bestOffset) + line.sublist(0, bestOffset);
  }

  return line;
}

addPoints(List<Point> line, int numPoints) {
  line = List<Point>.from(line);
  line.insert(line.length, line.first);

  double shift = 1 / (2 * numPoints);
  List<num> fractions = math.getFractions(line);
  List<num> newFractions = List<num>.from(fractions)
    ..addAll([for (double i = 0; i < numPoints; i++) i / numPoints + shift])
    ..sort()
    ..removeLast();

  return math.interpolateAlongAxis(newFractions, fractions, line);
}
