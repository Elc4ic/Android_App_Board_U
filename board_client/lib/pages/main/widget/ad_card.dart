import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/cache_service.dart';
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
    bool viewed = CacheService.getData(key: widget.ad.id) ?? false;
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
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                          gaplessPlayback: true,
                          width: Const.cellWidth,
                          fit: BoxFit.fitWidth,
                          "${Const.image_ad_api}${widget.ad.id}"),
                    ),
                    Visibility(
                      visible: viewed,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                color: Colors.black12,
                                padding: Markup.padding_all_2,
                                child: Text(
                                  "Просмотренно",
                                  style: Theme.of(context).textTheme.labelSmall,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Theme.of(context).colorScheme.surface,
                            child: Center(
                              child: FavButton(
                                adId: widget.ad.id,
                                isFav: widget.ad.isFav,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                padding: Markup.padding_all_8,
                child: Row(
                  children: [
                    Expanded(
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
