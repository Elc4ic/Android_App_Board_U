import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  FavButton({super.key, required this.isFav, required this.onPressed});

  bool isFav;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((isFav) ? Icons.favorite : Icons.favorite_border),
      onPressed: onPressed,
    );
  }
}
