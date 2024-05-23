import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/ad.pb.dart';
import '../../../values/values.dart';

class AdRow extends StatefulWidget {
  const AdRow({super.key, required this.ad});

  final Ad ad;

  @override
  State<AdRow> createState() => _AdRowState();
}

class _AdRowState extends State<AdRow> {
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
                        height: 100,
                      ),
                    ),
                    Markup.dividerW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Styles.TitleText16("${widget.ad.price} P"),
                        Styles.Text16(widget.ad.title),
                        Styles.Text12("активна"),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye),
                            Markup.dividerW5,
                            Styles.Text12("14"),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Wrap(
                direction: Axis.vertical,
                children: [
                  IconButton(
                    tooltip: SC.EDIT,
                    icon: const Icon(Icons.mode_edit),
                    onPressed: () => {},
                  ),
                  IconButton(
                    tooltip: SC.DELETE,
                    icon: const Icon(Icons.delete),
                    onPressed: () => {},
                  ),
                  IconButton(
                    tooltip: SC.HIDE,
                    icon: const Icon(Icons.closed_caption_disabled_outlined),
                    onPressed: () => {},
                  ),
                  IconButton(
                    tooltip: SC.CLOSE,
                    icon: const Icon(Icons.close),
                    onPressed: () => {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
