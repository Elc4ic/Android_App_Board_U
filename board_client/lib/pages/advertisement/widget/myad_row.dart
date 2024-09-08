import 'dart:typed_data';

import 'package:board_client/widgets/black_containers.dart';
import 'package:board_client/widgets/shimerring_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../../bloc/image_bloc/image_bloc.dart';
import '../../../data/repository/ad_repository.dart';
import '../../../data/repository/user_repository.dart';
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
  final AdListBloc adListBloc;

  @override
  State<AdRow> createState() => _AdRowState();
}

class _AdRowState extends State<AdRow> {
  var adRepository = GetIt.I<AdRepository>();
  var userRepository = GetIt.I<UserRepository>();

  final imageBloc = ImageBloc(
    GetIt.I<AdRepository>(),
  );

  @override
  Widget build(BuildContext context) {
    imageBloc.add(LoadImageList(widget.ad.id, true));
    return SizedBox(
      height: 120,
      child: Card(
        color: widget.ad.isActive ? null : Colors.black12,
        child: InkWell(
          onTap: () {
            context.push("/ad/${widget.ad.id}");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: HorizontalBlackBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Markup.dividerW10,
                      Container(
                        width: 90,
                        height: 90,
                        color: Colors.black12,
                        child: BlocBuilder<ImageBloc, ImageState>(
                          bloc: imageBloc,
                          builder: (context, state) {
                            if (state is ImageLoaded) {
                              return Image.memory(
                                gaplessPlayback: true,
                                fit: BoxFit.cover,
                                Uint8List.fromList(state.images.first),
                              );
                            }
                            if (state is ImageLoadingFailure) {
                              return NoImageWidget();
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                      Markup.dividerW10,
                      const VerticalDivider(width: 1),
                      Padding(
                        padding: Markup.padding_all_8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.ad.price} P",
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(
                                (widget.ad.title.length > 18)
                                    ? "${widget.ad.title.substring(0, 17)}..."
                                    : widget.ad.title,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(widget.ad.isActive ? SC.ACTIVE : SC.UNACTIVE,
                                style: Theme.of(context).textTheme.bodySmall),
                            Spacer(),
                            Row(
                              children: [
                                const Icon(Icons.remove_red_eye),
                                Markup.dividerW5,
                                Text(widget.ad.views.toString(),
                                    style: Theme.of(context).textTheme.bodySmall),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Wrap(
                direction: Axis.vertical,
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
                    icon: const Icon(Icons.closed_caption_disabled_outlined),
                    onPressed: () => myDialog(context, () async {
                      await adRepository.muteAd(widget.ad.id, widget.token);
                      widget.adListBloc.add(LoadMyAd());
                      context.pop();
                    }, "Вы уверенны, что хотите ${widget.ad.isActive ? "скрыть" : "показать"} объявление?"),
                  ),
                  IconButton(
                    tooltip: SC.CLOSE,
                    icon: const Icon(Icons.close),
                    onPressed: () => myDialog(context, () async {
                      await adRepository.deleteAd(widget.ad.id, widget.token);
                      widget.adListBloc.add(LoadMyAd());
                      context.pop();
                    }, SC.DELETE_AD),
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
