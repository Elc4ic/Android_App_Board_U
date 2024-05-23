import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/ad.pb.dart';
import '../../../values/values.dart';

class ChatRow extends StatefulWidget {
  const ChatRow({super.key, required this.ad});

  final Ad ad;

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: Markup.padding_all_8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Markup.dividerW10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Styles.Text12("05.06.2024  User"),
                        ],
                      ),
                      Row(
                        children: [
                          Styles.Text16(widget.ad.title),
                          Styles.TitleText16("  ${widget.ad.price}P"),
                        ],
                      ),
                      Markup.dividerH10,
                      Styles.Text12("Последнее сообщение"),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
