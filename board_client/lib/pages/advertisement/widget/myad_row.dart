import 'dart:typed_data';

import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/widgets/shimerring_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/ad.pb.dart';
import '../../../values/values.dart';
import 'my_dialog.dart';

class AdRow extends StatefulWidget {
  const AdRow(
      {super.key,
      required this.ad,
      required this.token,
      required this.adListBloc});

  final Ad ad;
  final String? token;
  final AdListCubit adListBloc;

  @override
  State<AdRow> createState() => _AdRowState();
}

class _AdRowState extends State<AdRow> {
  late final _adBloc = AdCubit.get(context);
  late final _imageBloc = ImageCubit.get(context);

  @override
  void initState() {
    _imageBloc.loadImages(widget.ad.id, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.ad.isActive ? MyColorConst.card : Colors.black12,
      child: InkWell(
        onTap: () {
          context.push("/ad/${widget.ad.id}");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: BlocBuilder<ImageCubit, ImageState>(
                    bloc: _imageBloc,
                    builder: (context, state) {
                      if (state is ImageLoaded) {
                        return Image.memory(
                          gaplessPlayback: true,
                          fit: BoxFit.cover,
                          cacheWidth: Const.ImageWidth,
                          cacheHeight: Const.ImageHeight,
                          Uint8List.fromList(state.images[widget.ad.id]!.first),
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
            ),
            Padding(
              padding: Markup.padding_all_8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.ad.price} P",
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(Markup.substringText(widget.ad.title, 17),
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(widget.ad.isActive ? SC.ACTIVE : SC.UNACTIVE,
                      style: Theme.of(context).textTheme.bodySmall),
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye),
                      Markup.dividerW5,
                      Text(widget.ad.views.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          IconButton(
                            tooltip: SC.EDIT,
                            icon: const Icon(Icons.mode_edit),
                            onPressed: () {
                              context.push("/my/change/${widget.ad.id}");
                            },
                          ),
                          IconButton(
                            tooltip: SC.HIDE,
                            icon: const Icon(
                                Icons.closed_caption_disabled_outlined),
                            onPressed: () => myDialog(context, () async {
                              _adBloc.muteAd(widget.ad.id, widget.token);
                              widget.adListBloc.getMyList();
                              context.pop();
                            }, "Вы уверенны, что хотите ${widget.ad.isActive ? "скрыть" : "показать"} объявление?"),
                          ),
                          IconButton(
                            tooltip: SC.CLOSE,
                            icon: const Icon(Icons.close),
                            onPressed: () => myDialog(context, () async {
                              _adBloc.deleteAd(widget.ad.id, widget.token);
                              widget.adListBloc.getMyList();
                              context.pop();
                            }, SC.DELETE_AD),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
