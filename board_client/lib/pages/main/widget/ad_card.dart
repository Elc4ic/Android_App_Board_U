import 'dart:typed_data';

import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:board_client/widgets/shimerring_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  late final _imageBloc = ImageCubit.get(context);

  @override
  void initState() {
    _imageBloc.loadImages(widget.ad.id, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              child: BlocBuilder<ImageCubit, ImageState>(
                bloc: _imageBloc,
                builder: (context, state) {
                  if (state is ImageLoaded) {
                    Uint8List bytes = Uint8List.fromList(state.images[widget.ad.id]!.first);
                    return Image.memory(
                      gaplessPlayback: true,
                      width: Const.cellWidth,
                      cacheWidth: Const.cardImageWidth,
                      cacheHeight: Const.cardImageHeight,
                      fit: BoxFit.cover,
                      bytes,
                    );
                  }
                  if (state is ImageLoadingFailure) {
                    return const NoImageWidget();
                  }
                  return ShimmeringContainer();
                },
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
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Markup.substringText(widget.ad.title, 26),
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("${widget.ad.price} ${SC.RUBLES}",
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(selectAddress(),
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FavButton(
                          onPressed: () async {
                            try {
                              await adRepository.setFavoriteAd(
                                  widget.ad.id, widget.token);
                              setState(() {
                                widget.ad.isFav = !widget.ad.isFav;
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Не получилось добавить в избранное"),
                                    backgroundColor: MyColorConst.error),
                              );
                            }
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
