import 'dart:math';
import './math.dart';

prepare(List<Point> start, List<Point> stop) {
  // handling a possible flip
  num diff =
      start.first.distanceTo(stop.first) + start.last.distanceTo(stop.last);
  num rev_diff =
      start.first.distanceTo(stop.last) + start.last.distanceTo(stop.first);
  if (rev_diff < diff) start = start.reversed.toList();

  List<num> start_fractions = getFractions(start);
  List<num> stop_fractions = getFractions(stop);
  List<num> merged = Set<num>.from(start_fractions)
      .union(Set<num>.from(stop_fractions))
      .toList()
        ..sort();

  start = interpolateAlongAxis(merged, start_fractions, start);
  stop = interpolateAlongAxis(merged, stop_fractions, stop);
  return [start, stop];
}
