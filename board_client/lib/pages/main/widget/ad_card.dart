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
      clipBehavior: Clip.hardEdge,
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
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Image.network(
                          gaplessPlayback: true,
                          width: Const.cellWidth,
                          fit: BoxFit.fitWidth,
                          "${Const.image_ad_api}${widget.ad.id}"),
                    ),
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
                              color: Colors.grey.withAlpha(150),
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
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10)),
                      ),
                      child: Center(
                        child: FavButton(
                          ad: widget.ad,
                        ),
                      ),
                    ),
                  )
                ],
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
    if (widget.ad.user.address.startsWith("Г")) {
      return "Город";
    }
    if (widget.ad.user.address == "") {
      return "Не указан";
    }
    return "Другое";
  }
}
