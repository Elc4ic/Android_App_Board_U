import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/pages/chats/widget/chat_row.dart';
import 'package:flutter/material.dart';
import 'package:fixnum/fixnum.dart' as fnum;

import '../../widgets/footers/navigation_bar.dart';

class ChatsPreviewPage extends StatefulWidget {
  const ChatsPreviewPage({super.key});

  @override
  State<ChatsPreviewPage> createState() => _ChatsPreviewPageState();
}

class _ChatsPreviewPageState extends State<ChatsPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SafeArea(
          child: Column(
            children: [
              ChatRow(
                ad: Ad(
                    id: fnum.Int64(0),
                    title: "fav#1",
                    price: fnum.Int64(100),
                    description: "dccedcccc",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
