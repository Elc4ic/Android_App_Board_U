import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repository/ad_repository.dart';
import '../../../generated/ad.pb.dart';

class RowCard extends StatefulWidget {
  const RowCard({super.key, required this.ad, required this.token});

  final Ad ad;
  final String? token;

  @override
  State<RowCard> createState() => _RowCardState();
}

class _RowCardState extends State<RowCard> {
  final adRepository = GetIt.I<AdRepository>();
  bool isFav = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: InkWell(
          onTap: () {
            context.push("/ad/${widget.ad.id}");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: Markup.padding_all_8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blueAccent,
                        width: 100,
                        height: 90,
                      ),
                    ),
                    Markup.dividerW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Styles.TitleText16("${widget.ad.price} P"),
                        Styles.Text16(widget.ad.title),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FavButton(
                    isFav: isFav,
                    onPressed: () {
                      setState(() {
                        isFav = !isFav;
                      });
                      adRepository.setFavoriteAd(widget.ad.id, widget.token);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
