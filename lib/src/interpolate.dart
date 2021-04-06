import 'dart:math';

import './math.dart' as math;
import './closed.dart' as closed_line;
import './open.dart' as open_line;

num _normalize_parameter(num t) {
  if (t < 0 || t > 1) {
    throw ArgumentError('The interpolation parameter must be between 0 and 1.');
  }
  return t;
}

List<Point> _normalize_line(List<Point> line) {
  assert(line.isNotEmpty);
  return line;
}

typedef Interpolator = List<Point> Function(num);

/// Creates a function that interpolates from [start] to [stop].
Interpolator interpolator(List<Point> start, List<Point> stop,
    {bool closed = true}) {
  start = _normalize_line(start);
  stop = _normalize_line(stop);

  if (closed) {
    var prepared = closed_line.prepare(start, stop);
    start = prepared[0];
    stop = prepared[1];
  } else {
    var prepared = open_line.prepare(start, stop);
    start = prepared[0];
    stop = prepared[1];
  }

  List<Point> interpolator(num t) {
    t = _normalize_parameter(t);
    List<Point> result = [];
    for (var i = 0; i < start.length; i++) {
      result.add(math.pointAlong(start[i], stop[i], t));
    }
    return result;
  }

  return interpolator;
}

/// Interpolates from [start] to [stop] with the interpolation parameter [t].
List<Point> interpolate(List<Point> start, List<Point> stop, num t,
    {bool closed = true}) {
  t = _normalize_parameter(t);
  return interpolator(start, stop, closed: closed)(t);
}
