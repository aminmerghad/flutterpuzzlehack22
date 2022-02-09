import 'dart:typed_data';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:puzzle/Controller/controller.dart';

class DecorPart extends StatelessWidget {
  const DecorPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9 < 500 ? context.width * 0.9 : 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Flutter Puzzle Hack',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Try to solve It :',
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Container(
              color: Colors.tealAccent[100],
              width: 200,
              height: 240,
              child: CustomPaint(
                painter: PuzzleDecoration(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class PuzzleDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipPath(Path()
      ..addRRect(
          RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(5))));
    canvas.drawShadow(
        Path()..addOval(Rect.fromCircle(center: Offset(0, 0), radius: 200)),
        Colors.grey[400] as Color,
        5,
        true);

    canvas.drawCircle(
        Offset(0, 0), 200, Paint()..color = Colors.tealAccent[400] as Color);
    canvas.drawShadow(
        Path()..addOval(Rect.fromCircle(center: Offset(0, 0), radius: 150)),
        Colors.grey[400] as Color,
        5,
        true);
    canvas.drawCircle(
        Offset(0, 0), 150, Paint()..color = Colors.tealAccent[700] as Color);
    canvas.save();
    int nm = (size.height / 50).round();
    for (var i = 1; i < nm; i++) {
      canvas.drawPath(
          Path()
            ..moveTo(10, i * 50 - 2)
            ..lineTo(size.width - 10, i * 50 - 2),
          Paint()
            ..color = Colors.black12
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }
    int nm2 = (size.width / 50).round();
    for (var i = 1; i < nm2; i++) {
      canvas.drawPath(
          Path()
            ..moveTo(i * 50 - 2, 10)
            ..lineTo(i * 50 - 2, size.height - 10),
          Paint()
            ..color = Colors.black12
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }
    canvas.transform(Float64List.fromList(
        [0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]));

    Path path2 = Path()..moveTo(b1.dx, b1.dy);
    for (var i in p1) {
      path2..lineTo(i.dx, i.dy);
    }
    canvas.drawShadow(path2, Colors.grey, 3, true);
    canvas.drawPath(path2, Paint()..color = Colors.amber[50] as Color);
    Path path3 = Path()..moveTo(b5.dx, b5.dy);
    for (var i in p2) {
      path3..lineTo(i.dx, i.dy);
    }
    canvas.drawShadow(path3, Colors.grey, 3, true);
    canvas.drawPath(path3, Paint()..color = Colors.amber[50] as Color);
    Path path4 = Path()..moveTo(b5.dx, b5.dy);
    for (var i in p3) {
      path4..lineTo(i.dx, i.dy);
    }
    canvas.drawShadow(path4, Colors.grey, 3, true);
    canvas.drawPath(path4, Paint()..color = Colors.amber[50] as Color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(PuzzleDecoration oldDelegate) => false;
}
