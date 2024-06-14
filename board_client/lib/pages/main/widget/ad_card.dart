import 'dart:typed_data';

import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repository/ad_repository.dart';
import '../../../generated/ad.pb.dart';

class AdCard extends StatefulWidget {
  const AdCard({super.key, required this.ad, this.token});

  final Ad ad;
  final String? token;

  @override
  State<AdCard> createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  final adRepository = GetIt.I<AdRepository>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            context.push("/ad/${widget.ad.id}");
          },
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Image.memory(
                  width: Const.cellWidth,
                  fit: BoxFit.fitWidth,
                  Uint8List.fromList(widget.ad.images.first.chunk),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: Markup.padding_all_8,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Styles.Text16(widget.ad.title),
                            Styles.TitleText16(
                                "${widget.ad.price} ${SC.RUBLES}"),
                            Styles.Text12(selectAddress()),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FavButton(
                              onPressed: () {
                                adRepository.setFavoriteAd(
                                    widget.ad.id, widget.token);
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
      ),
    );
  }

  String selectAddress() {
    if (widget.ad.user.address.startsWith("К")) {
      return "Кампус";
    }
    return "Город";
  }
}
