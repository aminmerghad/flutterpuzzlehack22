import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle/Controller/controller.dart';

class StatisticPart extends StatelessWidget {
  const StatisticPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Controller>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Card(
              elevation: 2,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Statistics :',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            GetBuilder<Controller>(
                                id: 'Tils',
                                builder: (Controller controller) {
                                  return Text(
                                    'Tiles: ${controller.tile}',
                                    style: TextStyle(color: Colors.black54),
                                  );
                                }),
                            GetBuilder<Controller>(
                                id: 'Win',
                                builder: (Controller controller) {
                                  return Column(
                                    children: [
                                      Text('Wins: ${controller.wins}',
                                          style:
                                              TextStyle(color: Colors.black54)),
                                      Text('Max move: ${controller.maxMove}',
                                          style:
                                              TextStyle(color: Colors.black54))
                                    ],
                                  );
                                }),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            GetBuilder<Controller>(
                                id: 'Move',
                                builder: (Controller controller) {
                                  return Text('Move: ${controller.move}',
                                      style: TextStyle(color: Colors.black54));
                                }),
                            GetBuilder<Controller>(
                                id: 'Loses',
                                builder: (Controller controller) {
                                  return Text('Loses: ${controller.loses}',
                                      style: TextStyle(color: Colors.black54));
                                }),
                            GetBuilder<Controller>(
                              id: 'Win',
                              builder: (Controller controller) => Text(
                                  'Min move: ${controller.minMove}',
                                  style: TextStyle(color: Colors.black54)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        child: Container(
                          width: 100,
                          height: 21,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Shuffle',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.restart_alt)
                            ],
                          ),
                        ),
                        onPressed: () {
                          if (controller.animationComplited == true) {
                            controller.updateLoses();
                            controller.shuffle();
                            controller.animationComplited = false;
                          }
                        }),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/dash.png'),
                    width: 140,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }
}
