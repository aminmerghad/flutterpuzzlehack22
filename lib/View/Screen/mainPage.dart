import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle/Controller/controller.dart';
import 'PuzzleColumnWidget.dart';
import 'DecoreColumnWidget.dart';
import 'StatisticsColumnWidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(
            child: Container(
              width: double.infinity,
              child: Center(
                child: GetBuilder<Controller>(
                    id: 'Tils',
                    builder: (Controller c) {
                      if (c.tile == 0) {
                        scrollController.jumpTo(0);
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'You win!!',
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Text('');
                      }
                    }),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.teal[50] as Color,
                  Colors.amber[50] as Color
                ]),
              ),
            ),
            height: context.width > 500? 135: context.width*0.25
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
