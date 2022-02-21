import 'dart:math';
import 'package:flutter/material.dart';

import '../../Widgets/PuzzlePiece.dart';

class ShuffleAnimation extends StatefulWidget {
  ShuffleAnimation({
    Key? key,
    required this.randInd,
    required this.index,
    this.isReady = false,
  }) : super(key: key);
  final int index;
  final bool isReady;
  final randInd;
  @override
  _ShuffleAnimationState createState() => _ShuffleAnimationState();
}

class _ShuffleAnimationState extends State<ShuffleAnimation>
    with SingleTickerProviderStateMixin<ShuffleAnimation> {
  AnimationController? _controller;
  double shuffleAnimationValue = 1;
  bool isReady = true;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller!.addListener(() {
      setState(() {
        shuffleAnimationValue = _controller!.value;
      });
    });
    onShufllefuture();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<void> onShufllefuture() async {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      _controller!.reset();
      var rand = Random();
      int p = rand.nextInt(400);
      if (isReady == true) setState(() => isReady = false);
      Future.delayed(Duration(milliseconds: 1000 + p))
          .then((value) => setState(() {
                isReady = true;
              }));
      Future.delayed(Duration(milliseconds: 1500)).then((value) => setState(() {
            _controller!.forward();
          }));
    });
  }

  void onShuflle() => onShufllefuture();

  @override
  Widget build(BuildContext context) {
    return MoveAnimation(
        restartStart: onShuflle,
        randInd: widget.randInd,
        isReady: isReady,
        shuffleAnimationValue: shuffleAnimationValue,
        index: widget.index);
  }
}

class MoveAnimation extends StatefulWidget {
  const MoveAnimation(
      {Key? key,
      required this.randInd,
      required this.index,
      required this.shuffleAnimationValue,
      required this.isReady,
      required this.restartStart})
      : super(key: key);
  final double shuffleAnimationValue;
  final int index;
  final bool isReady;
  final int randInd;
  final void Function() restartStart;
  @override
  State<MoveAnimation> createState() => _MoveAnimationState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MoveAnimationState extends State<MoveAnimation>
    with SingleTickerProviderStateMixin<MoveAnimation> {
  AnimationController? _controller;
  double secondAnimationValue = 1;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 380));
    _controller!.addListener(_update);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _update() => setState(() => secondAnimationValue = _controller!.value);

  void onTap() {
    if (_controller!.isCompleted) {
      _controller!.reset();
      _controller!.forward();
    } else {
      _controller!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBox(
        restartStart: widget.restartStart,
        isReady: widget.isReady,
        secondAnimationValue: secondAnimationValue,
        firstAnimationValue: widget.shuffleAnimationValue,
        start: onTap,
        child: Text('${widget.index}',
            style: TextStyle(fontSize: 18, color: Colors.amber[50] as Color)));
  }
}
