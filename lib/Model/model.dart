import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:puzzle/View/Painting/createPaint.dart';

import '../Controller/controller.dart';

class PuzzleParentData extends ContainerBoxParentData<RenderBox> {
  PuzzleParentData(
      {this.boxlength = 125,
      this.numbrRow = 4,
      required Controller controllero})
      :
        //_controller = Get.find<Pu>();
        controller = controllero;
  int? moveIndx;
  double boxlength;
  int numbrRow;
  int? _randIndex;
  int? _index;
  double? pStartPoint;
  double? pEndPoint;
  double? pMediumPoint;
  int get randIndex => _randIndex!;
  set randIndex(int rInd) {
    _randIndex = rInd;
    moveIndx = rInd;
  }

  int get index => _index!;
  set index(int oldI) {
    if (_index == null) _index = oldI;
    if (paints == null) paints = controller!.result[_index];
    idealposition = getPosition(_index!);
  }

  Offset? idealposition;
  Offset? translation;
  List<List<Offset>>? paints;
  Controller? controller;
  @override
  set offset(Offset _offset) {
    super.offset = _offset;
    if (idealposition != null) translation = _offset - idealposition!;
  }

  Offset getPosition(int _index) {
    double y = ((_index - 1) ~/ numbrRow).toInt().toDouble();
    double x = ((_index - (numbrRow * y)) - 1);
    return Offset(x * 125, y * 125);
  }

  void createAni() {
    Offset off1 = line2([
      Offset(super.offset.dx, super.offset.dy),
      Offset(super.offset.dx + 125, super.offset.dy + 125)
    ], [
      Offset(0, 0.01),
      Offset(0.01, 0)
    ]) as Offset;
    Offset off2 = line2([
      Offset(super.offset.dx, super.offset.dy),
      Offset(super.offset.dx + 125, super.offset.dy + 125)
    ], [
      Offset(500, 499.9),
      Offset(499.9, 500)
    ]) as Offset;

    double dist1 = sqrt(pow(off2.dx - off1.dx, 2) + pow(off2.dy - off1.dy, 2));
    double dist2 = sqrt(
        pow(off1.dx - super.offset.dx, 2) + pow(off1.dy - super.offset.dy, 2));
    double dist3 = sqrt(pow(off1.dx - super.offset.dx - 125, 2) +
        pow(off1.dy - super.offset.dy - 125, 2));

    pStartPoint = dist2 / dist1;
    pEndPoint = dist3 / dist1;
    pMediumPoint = (pEndPoint! + pStartPoint!) / 2;
  }
}
