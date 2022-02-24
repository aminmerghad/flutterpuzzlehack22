import 'dart:ui';

Offset? line(List<Offset> line1, List<Offset> line2) {
  Offset xdiff = Offset(line1[0].dx - line1[1].dx, line2[0].dx - line2[1].dx);
  Offset ydiff = Offset(line1[0].dy - line1[1].dy, line2[0].dy - line2[1].dy);

  double det(Offset a, Offset b) {
    return a.dx * b.dy - a.dy * b.dx;
  }

  double div = det(xdiff, ydiff);
  if (div == 0) return null;
  Offset d = Offset(det(line1[0], line1[1]), det(line2[0], line2[1]));
  double x = double.parse((det(d, xdiff) / div).toStringAsFixed(3));
  double y = double.parse((det(d, ydiff) / div).toStringAsFixed(3));
  double xcmparMax = line1[0].dx - line1[1].dx > 0 ? line1[0].dx : line1[1].dx;
  double xcmparMin = line1[0].dx - line1[1].dx > 0 ? line1[1].dx : line1[0].dx;

  double ycmparMax = line1[0].dy - line1[1].dy > 0 ? line1[0].dy : line1[1].dy;
  double ycmparMin = line1[0].dy - line1[1].dy > 0 ? line1[1].dy : line1[0].dy;

  return (xcmparMin <= x && xcmparMax >= x) &&
          (ycmparMin <= y && ycmparMax >= y) &&
          (line2[0].dx <= x && line2[1].dx >= x) &&
          (line2[0].dy <= y && line2[1].dy >= y)
      ? Offset(x, y)
      : null;
//   return Offset(x, y);
}

int fn(Offset b) => ((b.dx / 125) + (b.dy / 125) * 4 + 1).toInt();
List onlynonNull(List<Offset?> l) => l..removeWhere((value) => value == null);
int? deplacetheI(Offset o1, Offset o2, int i) {
  //
  if (o1.dx == o2.dx && o1.dy == o2.dy) {
    i = i - 5;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dx + 125 == o2.dx && o1.dy == o2.dy) {
    i = i - 3;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dx == o2.dx && o1.dy + 125 == o2.dy) {
    i = i + 3;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dx + 125 == o2.dx && o1.dy + 125 == o2.dy) {
    i = i + 5;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dy == o2.dy) {
    i = i - 4;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dx == o2.dx) {
    i = i - 1;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dx + 125 == o2.dx) {
    i = i + 1;
    return i < 16 && i > 0 ? i : null;
  }
  if (o1.dy + 125 == o2.dy) {
    i = i + 4;
    return i < 16 && i > 0 ? i : null;
  }
}

void recursionFn(
    Offset b, Offset e, int? i, Map<int, List<List<Offset>>> result) {
  if (i != null) {
    double y = ((i - 1) ~/ 4).toInt().toDouble() * 125;
    double x = ((i - (4 * (y / 125))) - 1) * 125;
    List nonNullIntersection = findAllInterSections(b, e, x, y)!;
    if (nonNullIntersection.isNotEmpty) {
      result.containsKey(i)
          ? result[i]!.add([b, nonNullIntersection[0]])
          : result[i] = [
              [b, nonNullIntersection[0]]
            ];
      recursionFn(nonNullIntersection[0], e,
          deplacetheI(Offset(x, y), nonNullIntersection[0], i), result);
    } else {
      result.containsKey(i)
          ? result[i]!.add([b, e])
          : result[i] = [
              [b, e]
            ];
    }
  }
}

List? findAllInterSections(Offset b, Offset e, double x, double y) {
  Offset? previousY = line([b, e], [Offset(x, y), Offset(x + 125, y)]);
  if (previousY == b) previousY = null;

  Offset? offLineYLeft = line([b, e], [Offset(x, y), Offset(x, y + 125)]);
  if (offLineYLeft == b) offLineYLeft = null;

  Offset? offLineYRghit =
      line([b, e], [Offset(x + 125, y), Offset(x + 125, y + 125)]);
  if (offLineYRghit == b) offLineYRghit = null;
  Offset? nextY = line([b, e], [Offset(x, y + 125), Offset(x + 125, y + 125)]);
  if (nextY == b) nextY = null;

  List? nonNull = onlynonNull([previousY, offLineYLeft, offLineYRghit, nextY]);
  return nonNull;
}

Offset? line2(List<Offset> line1, List<Offset> line2) {
  Offset xdiff = Offset(line1[0].dx - line1[1].dx, line2[0].dx - line2[1].dx);
  Offset ydiff = Offset(line1[0].dy - line1[1].dy, line2[0].dy - line2[1].dy);

  double det(Offset a, Offset b) {
    return a.dx * b.dy - a.dy * b.dx;
  }

  double div = det(xdiff, ydiff);
  if (div == 0) return null;
  Offset d = Offset(det(line1[0], line1[1]), det(line2[0], line2[1]));
  double x = double.parse((det(d, xdiff) / div).toStringAsFixed(3));
  double y = double.parse((det(d, ydiff) / div).toStringAsFixed(3));

  return Offset(x, y);
}
