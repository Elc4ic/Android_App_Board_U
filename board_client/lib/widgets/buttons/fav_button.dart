import 'package:board_client/data/service/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../cubit/ad_list_cubit/ad_list_cubit.dart';
import '../../cubit/fav_cubit/fav_cubit.dart';
import '../../generated/ad.pb.dart';

class FavButton extends StatefulWidget {
  const FavButton({super.key, required this.ad});

  final Ad ad;

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  final adService = GetIt.I<AdService>();
  late final _favBloc = FavCubit.get(context);
  late final _adListBloc = AdListCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((widget.ad.isFav) ? Icons.favorite : Icons.favorite_border),
      onPressed: () async {
        try {
          var response = await adService.setFavoriteAd(widget.ad.id);
          if (response) {
            widget.ad.isFav = !widget.ad.isFav;
            if (widget.ad.isFav) {
              _favBloc.addFav(widget.ad);
            } else {
              _favBloc.removeFav(widget.ad);
            }
            _adListBloc.update(widget.ad);
            setState(() {});
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
