
import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid(
      {super.key,
      required this.width,
      required this.items,
      required this.cellWidth});

  final double width;
  final int cellWidth;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    var gridCount = width ~/ cellWidth;
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        childAspectRatio: 2 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: items[index],
          );
      },
    );
  }
}
