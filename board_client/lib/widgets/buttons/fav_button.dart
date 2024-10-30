import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  const FavButton({super.key, required this.isFav, required this.onPressed});

  final bool isFav;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((isFav) ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        try {
          onPressed();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Не получилось добавить в избранное"),
            ),
          );
        }
      },
    );
  }
}
