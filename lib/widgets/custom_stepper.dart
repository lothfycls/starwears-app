import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 7.5),
              child: Row(
                  children: List.generate(1,
                      (index) => _buildDivider(currentIndex > index, index))),
            ),
            Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                      tag: 'first',
                      child: CircleStep(index: 0, currentIndex: currentIndex)),
                  Hero(
                      tag: 'second',
                      child: CircleStep(index: 1, currentIndex: currentIndex)),
                  Hero(
                      tag: 'third',
                      child: CircleStep(index: 2, currentIndex: currentIndex)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Arrived",
                  style: TextStyle(
                      color: currentIndex == 0
                          ? Color.fromARGB(255, 106, 208, 109)
                          : Color.fromARGB(255, 212, 211, 211),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Shipped",
                    style: TextStyle(
                        color: currentIndex == 1
                            ? Color.fromARGB(255, 106, 208, 109)
                            : Color.fromARGB(255, 212, 211, 211),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Text(
                  "Delivered",
                  style: TextStyle(
                      color: currentIndex == 2
                          ? Color.fromARGB(255, 106, 208, 109)
                          : Color.fromARGB(255, 212, 211, 211),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Flexible _buildDivider(bool selected, int index) {
    return Flexible(
      child: Hero(
        tag: index,
        child: Divider(
          color: selected
              ? Color.fromARGB(255, 106, 208, 109)
              : Color.fromARGB(255, 212, 211, 211),
          thickness: 4,
        ),
      ),
    );
  }
}

class CircleStep extends StatelessWidget {
  const CircleStep({
    Key? key,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);
  final int index;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 15,
        backgroundColor: currentIndex >= index
            ? Color.fromARGB(255, 106, 208, 109)
            : Color.fromARGB(255, 212, 211, 211),
        child: buildResult());
  }

  Widget? buildResult() {
    if (currentIndex > index) {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 20,
      );
    }
    if (currentIndex == index) {
      return Icon(
        Icons.done,
        color: Colors.white,
      );
    } else {
      return null;
    }
  }
}
