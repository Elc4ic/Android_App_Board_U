import 'dart:typed_data';

import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:board_client/widgets/shimerring_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../data/service/ad_service.dart';
import '../../../generated/ad.pb.dart';

class RowCard extends StatefulWidget {
  const RowCard({super.key, required this.ad, required this.token});

  final Ad ad;
  final String? token;

  @override
  State<RowCard> createState() => _RowCardState();
}

class _RowCardState extends State<RowCard> {
  final adService = GetIt.I<AdService>();
  late bool isFav = widget.ad.isFav;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColorConst.card,
      child: InkWell(
        onTap: () {
          context.push("/ad/${widget.ad.id}");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Markup.padding_all_8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.network(
                      gaplessPlayback: true,
                      width: Const.cellWidth,
                      cacheWidth: Const.cardImageWidth,
                      cacheHeight: Const.cardImageHeight,
                      fit: BoxFit.cover,
                      "http://api.dvfuboard.ru:8080/images/${widget.ad.id}"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: Markup.padding_h8_v16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.ad.price} P",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(Markup.substringText(widget.ad.title, 21),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            FavButton(
              isFav: isFav,
              onPressed: () async {
                try {
                  await adService.setFavoriteAd(widget.ad.id, widget.token);
                  setState(() {
                    isFav = !isFav;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Не получилось добавить в избранное"),
                        backgroundColor: MyColorConst.error),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
