import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

PreferredSizeWidget adHeader(bool isFav, String id) {
  bool fav = isFav;
  return PreferredSize(
    preferredSize: const Size.fromHeight(Const.HeaderHight),
    child: AppBar(actions: [
      FavButton(
        adId: id,
        isFav: fav,
      ),
    ]),
  );
}
