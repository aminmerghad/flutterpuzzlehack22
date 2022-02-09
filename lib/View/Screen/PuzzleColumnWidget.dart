import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../Widgets/Puzzle.dart';
import '../animation/CustomAnimations.dart';
import '/../Controller/controller.dart';

class PuzzlePart extends StatelessWidget {
  const PuzzlePart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Controller>();
    final List<int> listIndex = controller.simpleList;

    return Column(
      children: [
        Puzzle(
          controllero: controller,
          children: [
            for (int e in listIndex)
              CustPuzzle(
                index: e,
                randIndex: controller.randomList![e - 1],
                child: InitialAnimation(
                  isReady: false,
                  randInd: controller.randomList![e - 1],
                  index: e,
                ),
              )
          ],
        ),
        GetBuilder<Controller>(
            id: 'Win',
            builder: (Controller controller) {
              return Text('${controller.wining}');
            }),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
