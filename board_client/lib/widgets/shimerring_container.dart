import 'dart:async';

import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';

class ShimmeringContainer extends StatefulWidget {
  @override
  _ShimmeringContainerState createState() => _ShimmeringContainerState();
}

class _ShimmeringContainerState extends State<ShimmeringContainer> {
  var _index = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 300), (Timer timer) {
      setState(() {
        _index = (_index + 1) % 3;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: _index == 0 ? Colors.black45 : Colors.white70,
    );
  }
}

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
        ),
      ),
    );
  }
}