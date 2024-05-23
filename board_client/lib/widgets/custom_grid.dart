import 'package:flutter/material.dart';


class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key, required this.width, required this.items, required this.cellWidth});

  final double width;
  final int cellWidth;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width ~/ cellWidth,
        childAspectRatio: 5 / 6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
    );
  }
}
