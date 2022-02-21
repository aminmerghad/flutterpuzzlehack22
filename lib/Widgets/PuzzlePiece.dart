import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:puzzle/Model/model.dart';
import '../../Controller/controller.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class CustomBox extends SingleChildRenderObjectWidget {
  const CustomBox(
      {Key? key,
      required this.firstAnimationValue,
      required this.secondAnimationValue,
      required Widget child,
      required this.start,
      required this.isReady,
      required this.restartStart})
      : super(key: key, child: child);

  final double firstAnimationValue;
  final double secondAnimationValue;
  final void Function() start;
  final bool isReady;
  final void Function() restartStart;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomBox(
        restartStart: restartStart,
        isReady: isReady,
        value: secondAnimationValue,
        start: start);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    (renderObject as RenderCustomBox)
      ..initialAnimationValue = firstAnimationValue
      ..moveAnimationValue = secondAnimationValue
      ..isReady = isReady;
  }
}

class RenderCustomBox extends RenderShiftedBox
    implements MouseTrackerAnnotation {
  RenderCustomBox(
      {required void Function() restartStart,
      required bool isReady,
      required double value,
      RenderBox? child,
      required void Function() start})
      : _restartStart = restartStart,
        _moveAnimationValue = value,
        _start = start,
        _isReady = isReady,
        super(child);
  double arc = 5;
  double width = 0;
  double offsx = 0;
  double offsy = 0;
  double height = 0;
  int espaceBetweenBoxes = 5;
  int rowColumnNmbr = 4;
  Color color = Colors.tealAccent[400] as Color;
  Color hoverColor = Colors.tealAccent;
  bool paintNothing = true;
  double lengthOfRect = 120;
  double f = 240;
  double elevation = 5;
  double rap = 1;
  final double animationMovement = 0.4;
  late final TapGestureRecognizer _tapGestureRecognizer;
  late final MouseCursorManager _mouseCursorManager;
  List<Offset> solution2 = [];
  List<Offset> solution = [
    Offset(0, 125),
    Offset(125, 0),
    Offset(-125, 0),
    Offset(0, -125),
  ];

  //_isReady
  bool _isReady;
  bool get isReady => _isReady;
  set isReady(bool b) {
    if (_isReady == b) return;
    _isReady = b;
    if (b == true) {
      paintNothing = false;
      childparentData.offset =
          childparentData.getPosition(childparentData.randIndex);
      childparentData.createAni();
    } else
      childparentData.offset = childparentData.idealposition! * rap;
    markNeedsPaint();
  }

  void Function() _restartStart;
  void Function() get restartStart => _restartStart;
  set restartStart(void Function() res) {
    if (_restartStart == res) return;
    _restartStart = res;
  }

  //_start
  void Function() _start;
  void Function() get start => _start;
  set start(void Function() stat) {
    if (start == stat) return;
    _start = stat;
  }

  //_firstAnimationValue
  double _initialAnimationValue = 1;
  double get initialAnimationValue => _initialAnimationValue;
  set initialAnimationValue(double v) {
    if (_initialAnimationValue == v) return;
    bool b = childparentData.controller!.animationComplited;
    childparentData.offset =
        childparentData.getPosition(childparentData.randIndex) * rap;

    if (v == 1) {
      solution2 = solution.map((e) {
        Offset ld = e * rap;
        return Offset(ld.dx.roundToDouble(), ld.dy.roundToDouble());
      }).toList();
      missedPeace =
          childparentData.getPosition(childparentData.controller!.missedIndx!) *
              rap;
      markNeedsPaint();
    }
    if (v == 1 && b != true)
      childparentData.controller!.animationComplited = true;

    _initialAnimationValue = v;
    if (childparentData.pEndPoint != null) {
      if (v <= childparentData.pEndPoint! &&
          v >= childparentData.pStartPoint!) {
        f = lengthOfRect *
            2 *
            (initialAnimationValue - childparentData.pStartPoint!) /
            (childparentData.pEndPoint! - childparentData.pStartPoint!);
        paintNothing = true;
        markNeedsPaint();
      }
      if (v > childparentData.pEndPoint!) {
        paintNothing = true;
        markNeedsPaint();
      }
    }
  }

  //_secondAnimationValue
  double _moveAnimationValue;
  double get moveAnimationValue => _moveAnimationValue;
  set moveAnimationValue(double val) {
    if (val == moveAnimationValue) return;
    _moveAnimationValue = val;
    markNeedsPaint();
  }

  PuzzleParentData get childparentData => super.parentData as PuzzleParentData;

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _mouseCursorManager = MouseCursorManager(SystemMouseCursors.basic);
    _tapGestureRecognizer = TapGestureRecognizer(debugOwner: this)
      ..onTap = onTap;
  }

  void onTap() {
    int tile = childparentData.controller!.tile;
    if (isReady == true && initialAnimationValue == 1 && tile > 0) {
      Offset ofq = (childparentData.offset - missedPeace);
      if (solution2
          .contains(Offset(ofq.dx.roundToDouble(), ofq.dy.roundToDouble()))) {
        childparentData.controller!.move++;
        Offset ofs = missedPeace;
        int sw = childparentData.controller!.missedIndx!;
        childparentData.controller!.missedIndx = childparentData.moveIndx;
        childparentData.moveIndx = sw;
        missedPeace = childparentData.offset;
        childparentData.offset = ofs;
        start();
        checkActuelPosition();
      }
    }
  }

  void checkActuelPosition() {
    var updateTile = childparentData.controller!.updateTile;
    childparentData.offset == (childparentData.idealposition! * rap)
        ? updateTile(childparentData.index - 1, 1)
        : updateTile(childparentData.index - 1, 0);
  }

  @override
  void performLayout() {
    child?.layout(constraints.loosen(), parentUsesSize: true);
    size = Size(constraints.maxWidth, constraints.maxHeight);
    lengthOfRect = constraints.maxWidth;

    f = lengthOfRect * 2;
    rap = (lengthOfRect + espaceBetweenBoxes) / 125;
    if (isReady == false)
      childparentData.offset = childparentData.idealposition! * rap;

    solution2 = solution.map((e) {
      Offset ld = e * rap;
      return Offset(ld.dx.roundToDouble(), ld.dy.roundToDouble());
    }).toList();
    if (initialAnimationValue == 1 && isReady != false) {
      childparentData.offset =
          childparentData.getPosition(childparentData.moveIndx!) * rap;
      missedPeace =
          childparentData.getPosition(childparentData.controller!.missedIndx!) *
              rap;
      markNeedsPaint();
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent && initialAnimationValue == 1) {
      _tapGestureRecognizer.addPointer(event);
      return;
    }
  }

  double positivePass1(double arriveX, double startX) =>
      moveAnimationValue * ((arriveX - startX) / animationMovement) + startX;
  double positivePass2(double arriveX, double startX) =>
      moveAnimationValue * ((arriveX - startX) / (1 - animationMovement)) +
      (arriveX - (arriveX - startX) / (1 - animationMovement));
  @override
  bool get isRepaintBoundary => true;
  void paintmove() {
    offsx = childparentData.offset.dx;
    offsy = childparentData.offset.dy;
    width = offsx + lengthOfRect;
    height = offsy + lengthOfRect;

    if (moveAnimationValue < 1) {
      double startX = missedPeace.dx;
      double arriveX = childparentData.offset.dx;
      double startY = missedPeace.dy;
      double arriveY = childparentData.offset.dy;
      offsx = startX;
      offsy = startY;
      if (arriveX - startX >= 0 && arriveY - startY >= 0) {
        if (moveAnimationValue <= 0.4) {
          // value * ((arriveX - startX) / 0.4) + startX + lengthOfRect ;
          width = positivePass1(arriveX + lengthOfRect, startX + lengthOfRect);
          height = positivePass1(arriveY + lengthOfRect, startY + lengthOfRect);
        } else {
          offsx = positivePass2(arriveX, startX);
          offsy = positivePass2(arriveY, startY);
        }
      } else {
        width = startX + lengthOfRect;
        height = startY + lengthOfRect;
        offsx = arriveX;
        offsy = arriveY;
        if (moveAnimationValue <= 0.4) {
          offsx = positivePass1(arriveX, startX);
          offsy = positivePass1(arriveY, startY);
        } else {
          // width = value * ((arriveX - startX) / (1 - 0.4)) +
          //     (lengthOfRect + arriveX - (arriveX - startX) / (1 - 0.4));
          width = positivePass2(arriveX + lengthOfRect, startX + lengthOfRect);
          height = positivePass2(arriveY + lengthOfRect, startY + lengthOfRect);
        }
      }
    }
  }

  void paintPuzzlePeace(Canvas canvas) {
    Path path = Path();
    if (initialAnimationValue < 1) {
      Offset point1;
      Offset point2;
      if (f <= lengthOfRect) {
        point1 = Offset(offsx, offsy + f);
        point2 = Offset(offsx + f, offsy);
        path = path
          ..moveTo(offsx, offsy + arc)
          ..quadraticBezierTo(offsx, offsy, offsx + arc, offsy)
          ..lineTo(point2.dx, point2.dy)
          ..lineTo(point1.dx, point1.dy)
          ..lineTo(offsx, offsy + arc);
      } else {
        point1 = Offset(offsx + f - lengthOfRect, offsy + lengthOfRect);
        point2 = Offset(offsx + lengthOfRect, offsy + f - lengthOfRect);
        path = path
          ..moveTo(offsx, offsy + arc)
          ..quadraticBezierTo(offsx, offsy, offsx + arc, offsy)
          ..lineTo(width - arc, offsy)
          ..quadraticBezierTo(width, offsy, width, offsy + arc)
          ..lineTo(point2.dx, point2.dy)
          ..lineTo(point1.dx, point1.dy)
          ..lineTo(offsx + arc, height)
          ..quadraticBezierTo(offsx, height, offsx, height - arc)
          ..lineTo(offsx, offsy + arc);
      }

      if (width - arc < point2.dx && height - arc < point2.dy) {
        path = Path()
          ..moveTo(offsx, offsy + arc)
          ..quadraticBezierTo(offsx, offsy, offsx + arc, offsy)
          ..lineTo(width - arc, offsy)
          ..quadraticBezierTo(width, offsy, width, offsy + arc)
          ..lineTo(width, height - arc)
          ..quadraticBezierTo(width, height, width - arc, height)
          ..lineTo(offsx + arc, height)
          ..quadraticBezierTo(offsx, height, offsx, height - arc)
          ..lineTo(offsx, offsy + arc);
      } else {
        canvas.drawLine(
            point1 + Offset(4, 4) * rap,
            point2 + Offset(4, 4) * rap,
            Paint()
              ..color = Colors.teal[50] as Color
              ..strokeWidth = 4 * rap);
      }
    } else {
      path = path
        ..moveTo(offsx, offsy + arc)
        ..quadraticBezierTo(offsx, offsy, offsx + arc, offsy)
        ..lineTo(width - arc, offsy)
        ..quadraticBezierTo(width, offsy, width, offsy + arc)
        ..lineTo(width, height - arc)
        ..quadraticBezierTo(width, height, width - arc, height)
        ..lineTo(offsx + arc, height)
        ..quadraticBezierTo(offsx, height, offsx, height - arc)
        ..lineTo(offsx, offsy + arc);
    }
    canvas.drawShadow(path, Colors.grey, elevation, true);
    canvas.drawPath(path, Paint()..color = color);
    canvas.clipPath(path);
  }

  void paintImagePuzzle(Canvas canvas) {
    double y =
        ((childparentData.index - 1) ~/ rowColumnNmbr).toInt().toDouble();
    double x = (childparentData.index - (rowColumnNmbr * y)) - 1;
    Offset ins = Offset(offsx - x * (lengthOfRect + espaceBetweenBoxes),
        offsy - y * (lengthOfRect + espaceBetweenBoxes));
    if (childparentData.paints != null) {
      Paint _paint = Paint()
        ..color = Colors.white
        ..strokeWidth = 3.0 * rap
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round;
      List<List<Offset>>? lisPaint = childparentData.paints;
      // Offset translation = childparentData.translation!;
      double moveX = ((width - offsx) - lengthOfRect) / rowColumnNmbr;
      double moveY = ((height - offsy) - lengthOfRect) / rowColumnNmbr;
      for (List<Offset> i in lisPaint!) {
        Path path = Path();
        double x1 = i[0].dx * rap + ins.dx;
        double y1 = i[0].dy * rap + ins.dy;
        double x2 = i[1].dx * rap + ins.dx;
        double y2 = i[1].dy * rap + ins.dy;
        path.moveTo(x1, y1);
        path.lineTo(x2 + moveX, y2 + moveY);
        canvas.drawPath(path, _paint);
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (paintNothing) {
      context.canvas.save();
      paintmove();
      paintPuzzlePeace(context.canvas);
      paintImagePuzzle(context.canvas);
      Offset childOffset = Offset(offsx, offsy) +
          Offset((width - offsx) / 2, (height - offsy) / 2) -
          Offset(child!.size.width / 2, child!.size.height / 2);
      if (child != null) context.paintChild(child as RenderObject, childOffset);
      context.canvas.restore();
    }
  }

  @override
  MouseCursor get cursor => MouseCursor.defer;

  @override
  PointerEnterEventListener? get onEnter => (PointerEnterEvent? p) {
        if (initialAnimationValue == 1) {
          _mouseCursorManager.handleDeviceCursorUpdate(
              p!.device, p, [SystemMouseCursors.click]);
          color = hoverColor;
          elevation = 8;
          markNeedsPaint();
        }
      };

  @override
  PointerExitEventListener? get onExit => (PointerExitEvent? p) {
        if (initialAnimationValue == 1) {
          _mouseCursorManager.handleDeviceCursorUpdate(
              p!.device, p, [SystemMouseCursors.basic]);
          color = Colors.tealAccent[400] as Color;
          elevation = 5;
          markNeedsPaint();
        }
      };

  @override
  bool get validForMouseTracker => true;
}
