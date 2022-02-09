import 'dart:math';
import 'package:flutter/material.dart';

import '/../Widgets/PuzzlePeace.dart';

class InitialAnimation extends StatefulWidget {
  InitialAnimation({
    Key? key,
    required this.randInd,
    required this.index,
    this.isReady = false,
  }) : super(key: key);
  final int index;
  final bool isReady;
  final randInd;
  @override
  _InitialAnimationState createState() => _InitialAnimationState();
}

class _InitialAnimationState extends State<InitialAnimation>
    with SingleTickerProviderStateMixin<InitialAnimation> {
  AnimationController? controller;
  double firstAnimationValue = 1;
  bool isReady = true;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    controller!.addListener(() {
      setState(() {
        firstAnimationValue = controller!.value;
      });
    });

    onShufllefuture();
  }

  Future<void> onShufllefuture() async {
    controller!.reset();
    var rand = Random();
    int p = rand.nextInt(600);
    if (isReady == true)
      setState(() {
        isReady = false;
      });
    Future.delayed(Duration(milliseconds: 1000 + p))
        .then((value) => setState(() {
              isReady = true;
            }));
    Future.delayed(Duration(milliseconds: 1800)).then((value) => setState(() {
          controller!.forward();
        }));
  }

  void onShuflle() => onShufllefuture();

  @override
  Widget build(BuildContext context) {
    return MoveAnimation(
        restartStart: onShuflle,
        randInd: widget.randInd,
        isReady: isReady,
        firstAnimationValue: firstAnimationValue,
        index: widget.index);
  }
}

class MoveAnimation extends StatefulWidget {
  const MoveAnimation(
      {Key? key,
      required this.randInd,
      required this.index,
      required this.firstAnimationValue,
      required this.isReady,
      required this.restartStart})
      : super(key: key);
  final double firstAnimationValue;
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
        vsync: this, duration: const Duration(milliseconds: 400));
    _controller!.addListener(_update);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _update() {
    setState(() {
      secondAnimationValue = _controller!.value;
    });
  }

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
        randInd: widget.randInd,
        isReady: widget.isReady,
        secondAnimationValue: secondAnimationValue,
        firstAnimationValue: widget.firstAnimationValue,
        start: onTap,
        child: Text('${widget.index}',
            style: TextStyle(fontSize: 16, color: Colors.amber[50] as Color)));
  }
}
