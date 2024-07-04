import 'dart:typed_data';

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
  void initState() {
    imageBloc.add(LoadImageList(widget.ad.id, true, widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        color: widget.ad.isActive ? Colors.white : Colors.black12,
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
                        width: 90,
                        height: 90,
                        color: Colors.black12,
                        child: BlocBuilder<ImageBloc, ImageState>(
                          bloc: imageBloc,
                          builder: (context, state) {
                            if (state is ImageLoaded) {
                              return Image.memory(
                                fit: BoxFit.fitWidth,
                                Uint8List.fromList(state.images.first),
                              );
                            }
                            if (state is ImageLoadingFailure) {
                              return Container();
                            }
                            return const Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                    Markup.dividerW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Styles.TitleText16("${widget.ad.price} P"),
                        Styles.Text16("${(widget.ad.title.length>19)?widget.ad.title.substring(0,19):widget.ad.title}..."),
                        Styles.Text12(
                            widget.ad.isActive ? "активно" : "не активно"),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye),
                            Markup.dividerW5,
                            Styles.Text12(widget.ad.views.toString()),
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
                    tooltip: SC.HIDE,
                    icon: const Icon(Icons.closed_caption_disabled_outlined),
                    onPressed: () => myDialog(context, () async {
                      await adRepository.muteAd(widget.ad.id, widget.token);
                      context.pop();
                      widget.adListBloc.add(LoadMyAd());
                    },"Вы уверенны, что хотите скрыть объявление?"),
                  ),
                  IconButton(
                    tooltip: SC.CLOSE,
                    icon: const Icon(Icons.close),
                    onPressed: () => myDialog(context, () async {
                      await adRepository.deleteAd(widget.ad.id, widget.token);
                      context.pop();
                      widget.adListBloc.add(LoadMyAd());
                    },"Вы уверенны, что хотите удалить объявление?"),
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
