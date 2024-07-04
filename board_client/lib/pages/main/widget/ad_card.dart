import 'dart:typed_data';

import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/image_bloc/image_bloc.dart';
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

  final _imageBloc = ImageBloc(
    GetIt.I<AdRepository>(),
  );

  @override
  void initState() {
    _imageBloc.add(LoadImageList(widget.ad.id, true, widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ClipRRect(
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
                child: BlocBuilder<ImageBloc, ImageState>(
                  bloc: _imageBloc,
                  builder: (context, state) {
                    if (state is ImageLoaded) {
                      return PageView.builder(
                        itemCount: state.images.length,
                        pageSnapping: true,
                        itemBuilder: (context, pagePosition) {
                          return Image.memory(
                            width: Const.cellWidth,
                            fit: BoxFit.fitWidth,
                            Uint8List.fromList(state.images.first),
                          );
                        },
                      );
                    }
                    if (state is ImageLoadingFailure) {
                      return Container(
                        color: Colors.blueAccent,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
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
                            Styles.Text16((widget.ad.title.length<30?widget.ad.title:"${widget.ad.title.substring(0,30)}...")),
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
    if (widget.ad.user.address.startsWith("Г") || widget.ad.user.address.startsWith("Д")) {
      return "Город";
    }
    return "Не указан";
  }
}
