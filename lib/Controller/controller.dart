import 'dart:ui';
import 'dart:math';

import '../View/Painting/createPaint.dart';
import 'package:get/get.dart';

Offset b1 = Offset(27.67922, 222.29873);
Offset e1 = Offset(238.73326, 28.54419);
Offset b2 = Offset(238.73326, 28.54419);
Offset e2 = Offset(366.7, 28.5);
Offset b3 = Offset(366.7, 28.5);
Offset e3 = Offset(86.2, 286.1);
Offset b4 = Offset(86.2, 286.1);
Offset e4 = Offset(27.67922, 222.29873);

Offset b5 = Offset(126.2, 329.6);
Offset e5 = Offset(193.9, 267.5);
Offset b6 = Offset(193.9, 267.5);
Offset e6 = Offset(238.7, 226.3);
Offset b7 = Offset(238.7, 226.3);
Offset e7 = Offset(366.7, 226.3);
Offset b8 = Offset(366.7, 226.3);
Offset e8 = Offset(250.9, 332.7);
Offset b9 = Offset(250.9, 332.7);
Offset e9 = Offset(184.8, 393.4);
Offset b10 = Offset(184.8, 393.4);
Offset e10 = Offset(126.2, 329.6);

Offset b11 = Offset(184.8, 393.4);
Offset e11 = Offset(238.7, 452.2);
Offset b12 = Offset(238.7, 452.2);
Offset e12 = Offset(366.7, 455.7);
Offset b13 = Offset(366.7, 455.7);
Offset e13 = Offset(250.9, 332.7);
Offset b14 = Offset(250.9, 332.7);
Offset e14 = Offset(191.5, 269.7);
//b1
List p1 = [
  e1,
  e2,
  e3,
  b1,
];
//b5
List p2 = [e5, b13, b12, b5];
//
List p3 = [
  e6,
  e7,
  e9,
  b5,
];
List listOfPaint = [
  [b1, e1],
  [b2, e2],
  [b3, e3],
  [b4, e4],
  [b5, e5],
  [b6, e6],
  [b7, e7],
  [b8, e8],
  [b9, e9],
  [b10, e10],
  [b11, e11],
  [b12, e12],
  [b13, e13],
  [b14, e14]
];
Offset missedPeace = Offset(0, 0);

class AllController extends Bindings {
  @override
  void dependencies() {
    Get.put<Controller>(
      Controller(rowColumn: 4),
    );
  }
}

class Controller extends GetxController {
  Controller({required this.rowColumn, this.boxLength = 120}) {
    cutPaint();
    inialisation();
  }
  int? missedIndx;
  Function? repaint;
  bool _animationComplited = false;
  double boxLength;
  int rowColumn;
  List<int> simpleList = List<int>.generate(15, (i) => i + 1);
  List<int>? randomList;
  // Offset? missedPiece;
  bool get animationComplited => _animationComplited;
  set animationComplited(bool b) {
    if (b == _animationComplited) return;
    _animationComplited = b;
    // if (_animationComplited == true) print('Correction');
  }

  int _wins = 0;
  int get wins => _wins;

  int maxMove = 0;
  int? _minMove;
  int get minMove => _minMove == null ? 0 : _minMove!;
  int _loses = 0;
  int get loses => _loses;
  updateLoses() {
    if (tile > 0) {
      _loses++;
      update(['Loses']);
    }
  }

  String wining = '';
  int _move = 0;
  int get move => _move;
  set move(int i) {
    _move = i;
    update(['Move']);
  }

  void shuffle() {
    if (repaint != null) {
      inialisation();
      update(['Move']);
      update(['Tails']);
      repaint!(randomList);
    }
  }

  List<int> _tile = List<int>.generate(15, (i) => 0);
  int get tile =>
      _tile.fold<int>(15, (previousValue, element) => previousValue - element);
  void updateTile(int index, int value) {
    _tile[index] = value;
    if (tile == 0) {
      maxMove = max(_move, maxMove);
      _minMove != null ? _minMove = min(_move, _minMove!) : _minMove = _move;
      _wins++;
      update(['Win']);
    }
    update(['Tails']);
  }

  Map<int, List<List<Offset>>> result = <int, List<List<Offset>>>{};
  void inialisation() {
    _move = 0;
    var rand = Random();
    int i = rand.nextInt(15);
    List<int> lq = List<int>.generate(16, (i) => i + 1)..shuffle();
    int indMissedPeace = lq[i];
    lq.removeAt(i);
    missedIndx = indMissedPeace;
    randomList = lq;
    _tile = List<int>.generate(15, (i) => 0);
    for (int i in simpleList) if (randomList![i - 1] == i) _tile[i - 1] = 1;
    double y = ((indMissedPeace - 1) ~/ 4).toInt().toDouble();
    double x = (indMissedPeace - (4 * y)) - 1;
    missedPeace = Offset(x * 125, y * 125);
  }

  void cutPaint() {
    for (List<Offset> i in listOfPaint) {
      double x = (i[0].dx ~/ 125).toInt() * 125;
      double y = (i[0].dy ~/ 125).toInt() * 125;
      int index = ((x + 4 * y + 125) ~/ 125).toInt();
      recursionFn(i[0], i[1], index, result);
    }
  }

  Map<int, Offset> shf() {
    var rand = Random();
    Map<int, Offset> rs = {};
    List<int> q = List<int>.generate(15, (i) => i + 1);
    List<int> q2 = List<int>.generate(16, (i) => i + 1);

    for (int i in q) {
      int raIndex = rand.nextInt(q2.length);
      // while (i == raIndex) {
      //   raIndex = rand.nextInt(q2.length);
      // }
      double y = ((q2[raIndex] - 1) ~/ 4).toInt().toDouble();
      double x = (q2[raIndex] - (4 * y)) - 1;
      rs[i] = Offset(x * 125, y * 125);
      q2.removeAt(raIndex);
    }
    double y = ((q2[0] - 1) ~/ 4).toInt().toDouble();
    double x = (q2[0] - (4 * y)) - 1;
    missedPeace = Offset(x * 125, y * 125);
    return rs;
  }
}
