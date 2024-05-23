import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/ad.pb.dart';

class RowCard extends StatefulWidget {
  const RowCard({super.key, required this.ad});

  final Ad ad;

  @override
  State<RowCard> createState() => _RowCardState();
}

class _RowCardState extends State<RowCard> {
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
                  FavButton(isFav: false, onPressed: () => {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
