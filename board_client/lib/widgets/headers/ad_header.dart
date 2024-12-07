import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/material.dart';

import '../../generated/ad.pb.dart';
import '../../values/values.dart';

PreferredSizeWidget adHeader(Ad ad) {
  bool fav = ad.isFav;
  return PreferredSize(
    preferredSize: const Size.fromHeight(Const.HeaderHight),
    child: AppBar(actions: [
      FavButton(
        ad: ad,
      ),
    ]),
  );
}
