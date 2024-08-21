import 'dart:typed_data';

import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/buttons/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/image_bloc/image_bloc.dart';
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
                      child: BlocBuilder<ImageBloc, ImageState>(
                        bloc: _imageBloc,
                        builder: (context, state) {
                          if (state is ImageLoaded) {
                            return Image.memory(
                              width: 100,
                              height: 90,
                              fit: BoxFit.fitWidth,
                              Uint8List.fromList(state.images.first),
                            );
                          }
                          if (state is ImageLoadingFailure) {
                            return Container(
                              width: 100,
                              height: 90,
                              color: Colors.blueAccent,
                            );
                          }
                          return const SizedBox(
                              width: 100,
                              height: 90,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        },
                      ),
                    ),
                    Markup.dividerW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.ad.price} P",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text( (widget.ad.title.length > 21)
                            ? "${widget.ad.title.substring(0, 20)}..."
                            : widget.ad.title,
                            style: Theme.of(context).textTheme.bodyMedium),
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
