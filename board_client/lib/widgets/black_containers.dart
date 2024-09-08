import 'package:flutter/material.dart';

class BlackBox extends StatelessWidget {
  const BlackBox({super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      padding: padding,
      child: child,
    );
  }
}

class HorizontalBlackBox extends StatelessWidget {
  const HorizontalBlackBox(
      {super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 1),
          right: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class VerticalBlackBox extends StatelessWidget {
  const VerticalBlackBox(
      {super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 1),
        bottom: BorderSide(width: 1),
      )),
      padding: padding,
      child: child,
    );
  }
}

class RBlackBox extends StatelessWidget {
  const RBlackBox({super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class LBlackBox extends StatelessWidget {
  const LBlackBox({super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class BBlackBox extends StatelessWidget {
  const BBlackBox({super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class TBlackBox extends StatelessWidget {
  const TBlackBox({super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class VBlackBox extends StatelessWidget {
  const VBlackBox({super.key, required this.child, this.height, this.padding});

  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class BLBlackBox extends StatelessWidget {
  const BLBlackBox({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class RBBlackBox extends StatelessWidget {
  const RBBlackBox({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}

class TRBBlackBox extends StatelessWidget {
  const TRBBlackBox({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
          right: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
