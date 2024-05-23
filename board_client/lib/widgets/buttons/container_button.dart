import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatefulWidget {
  const CustomContainerButton({
    super.key,
    required this.text,
    required this.backcolor,
    required this.onTap,
    required this.radius,
  });

  final Widget text;
  final Color backcolor;
  final double radius;
  final GestureTapCallback? onTap;

  @override
  State<CustomContainerButton> createState() => _CustomContainerButtonState();
}

class _CustomContainerButtonState extends State<CustomContainerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Markup.padding_all_2,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        child: InkWell(
          onTap: (widget.onTap),
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: widget.backcolor,
            ),
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Center(
                child: widget.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
