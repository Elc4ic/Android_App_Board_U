import 'package:board_client/widgets/black_containers.dart';
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
        if (index < gridCount-1)
          return TRBBlackBox(child: items[index]);
        else if (index == gridCount-1)
          return VBlackBox(child: items[index]);
        else if (index % gridCount == 1)
          return BBlackBox(child: items[index]);
        else
          return RBBlackBox(child: items[index]);
      },
    );
  }
}
