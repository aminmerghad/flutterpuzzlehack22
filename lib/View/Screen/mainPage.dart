import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'PuzzleColumnWidget.dart';
import 'DecoreColumnWidget.dart';
import 'StatisticsColumnWidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.teal[50] as Color,
                  Colors.amber[50] as Color
                ]),
              ),
            ),
            height: context.width * 0.08,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.teal[50] as Color,
                Colors.amber[50] as Color
              ]),
            ),
            child: Wrap(
              children: [
                Container(
                    width: context.width > 1000
                        ? context.width * 1 / 4
                        : context.width,
                    child: Center(child: const DecorPart())),
                Container(
                    width: context.width > 1000
                        ? context.width * 2 / 4
                        : context.width,
                    child: Center(child: const PuzzlePart())),
                Container(
                  width: context.width > 1000
                      ? context.width * 1 / 4
                      : context.width,
                  child: Center(child: const StatisticPart()),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
