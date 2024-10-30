import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/ad.pb.dart';

class AdCard extends StatefulWidget {
  const AdCard({super.key, required this.ad, this.token});

  final Ad ad;
  final String? token;

  @override
  State<AdCard> createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  final adRepository = GetIt.I<AdService>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          context.push("/ad/${widget.ad.id}");
        },
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    gaplessPlayback: true,
                    width: Const.cellWidth,
                    cacheWidth: Const.cardImageWidth,
                    cacheHeight: Const.cardImageHeight,
                    fit: BoxFit.fitWidth,
                    "${Const.image_ad_api}${widget.ad.id}"),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                padding: Markup.padding_all_8,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Markup.substringText(widget.ad.title, 26),
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text("${widget.ad.price} ${SC.RUBLES}",
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(selectAddress(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FavButton(
                            onPressed: () async {
                              await adRepository.setFavoriteAd(widget.ad.id);
                              setState(() {
                                widget.ad.isFav = !widget.ad.isFav;
                              });
                            },
                            isFav: widget.ad.isFav,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String selectAddress() {
    if (widget.ad.user.address.startsWith("К")) {
      return "Кампус";
    }
    if (widget.ad.user.address.startsWith("Г") ||
        widget.ad.user.address.startsWith("Д")) {
      return "Город";
    }
    return "Не указан";
  }
}
