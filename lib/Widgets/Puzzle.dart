import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:puzzle/Model/model.dart';
import 'PuzzlePeace.dart';
import '../../Controller/controller.dart';

class Puzzle extends MultiChildRenderObjectWidget {
  Puzzle(
      {Key? key, List<Widget> children = const [], required this.controllero})
      : super(key: key, children: children);
  final Controller controllero;
  @override
  RenderPuzzle createRenderObject(BuildContext context) {
    return RenderPuzzle(controllero: controllero);
  }
  // @override
  // void updateRenderObject(
  //     BuildContext context, covariant RenderObject renderObject) {
  // }
}

class CustPuzzle extends ParentDataWidget<PuzzleParentData> {
  const CustPuzzle(
      {Key? key, required child, required this.index, required this.randIndex})
      : super(child: child, key: key);
  final int index;
  final int randIndex;
  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as PuzzleParentData;
    parentData.index = index;
    parentData.randIndex = randIndex;
    parentData.offset = parentData.idealposition!;

    final targetObject = renderObject.parent;
    if (targetObject is RenderObject) {
      targetObject.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Puzzle;
}

class RenderPuzzle extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, PuzzleParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, PuzzleParentData> {
  RenderPuzzle({required this.controllero}) {
    this.controllero.repaint = restarfirstAnimation;
  }
  int _rowColumnNumber = 4;
  double _spaceBetweenBoxes = 5;
  double _boxlength = 120;
  final Controller controllero;
  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! PuzzleParentData) {
      child.parentData = PuzzleParentData(controllero: controllero);
    }
  }

  @override
  void performLayout() {
    double wh = _boxlength * _rowColumnNumber +
        _spaceBetweenBoxes * (_rowColumnNumber - 1);
    if (constraints.maxWidth < 555.555) wh = constraints.maxWidth * 0.90;
    double wHchildren =
        ((wh - _spaceBetweenBoxes * (_rowColumnNumber - 1)) / _rowColumnNumber);
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as PuzzleParentData;
      child.layout(
          BoxConstraints(
              maxHeight: wHchildren,
              minHeight: 0,
              maxWidth: wHchildren,
              minWidth: 0),
          parentUsesSize: false);

      child = childParentData.nextSibling;
    }
    size = Size(wh, wh);
  }

  void restarfirstAnimation(List<int> ranIndx) {
    RenderObject? child = firstChild;
    int i = 0;
    while (child != null) {
      final childParentData = child.parentData! as PuzzleParentData;
      childParentData.randIndex = ranIndx[i];
      (child as RenderCustomBox).restartStart();
      child = childParentData.nextSibling;
      i++;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    var paint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[Colors.grey[400] as Color, Colors.grey[300] as Color],
      ).createShader(
        Rect.fromLTWH(offset.dx, offset.dy, offset.dx + size.width,
            offset.dy + size.height),
      );
    context.canvas.drawRRect(
        RRect.fromLTRBR(offset.dx, offset.dy, offset.dx + size.width,
            offset.dy + size.height, Radius.circular(5.0)),
        Paint()..color = Colors.amber[50] as Color);
    context.canvas.drawRRect(
        RRect.fromLTRBR(offset.dx, offset.dy, offset.dx + size.width,
            offset.dy + size.height, Radius.circular(5.0)),
        paint
          ..maskFilter =
              MaskFilter.blur(BlurStyle.outer, convertRadiusToSigma(6)));
    context.canvas.restore();
    RenderObject? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as PuzzleParentData;
      context.paintChild(child, offset);
      child = childParentData.nextSibling;
    }
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
