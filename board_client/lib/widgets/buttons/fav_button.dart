import 'package:board_client/data/service/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FavButton extends StatefulWidget {
  const FavButton({super.key, required this.isFav, required this.adId});

  final String adId;
  final bool isFav;

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  final adService = GetIt.I<AdService>();
  late bool isFav = false;

  @override
  void initState() {
    isFav = widget.isFav;
    super.initState();
  }

  @override
  void dispose() {
    isFav = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((isFav) ? Icons.favorite : Icons.favorite_border),
      onPressed: () async {
        try {
          var response = await adService.setFavoriteAd(widget.adId);
          if (response) {
            setState(() {
              isFav = !isFav;
            });
            if (isFav) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("Добавленно в избранное"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
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
