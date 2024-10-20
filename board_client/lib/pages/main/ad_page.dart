import 'dart:typed_data';

import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/headers/ad_header.dart';
import 'package:board_client/widgets/shimerring_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/service/chat_service.dart';
import '../../data/service/user_service.dart';
import '../../widgets/mini_profile.dart';
import '../../widgets/widgets.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key, required this.idAd});

  final Int64 idAd;

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  final chatService = GetIt.I<ChatService>();
  final String? token = GetIt.I<UserService>().getToken();

  late final _adBloc = AdCubit.get(context);
  late final _imageBloc = ImageCubit.get(context);

  bool isFav = false;
  int imageCount = 1;
  int imageMax = 1;

  @override
  void initState() {
    _adBloc.loadAd(id: widget.idAd, token: token);
    _imageBloc.loadImages(widget.idAd, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SafeArea(
          child: BlocConsumer<AdCubit, AdState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AdLoaded) {
                return Scaffold(
                  appBar: adHeader(
                    state.ad.isFav,
                    () async {
                      try {
                        await _adBloc.setFavorite(state.ad.id, token);
                        setState(
                          () {
                            isFav = !isFav;
                          },
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Не получилось добавить в избранное"),
                              backgroundColor: MyColorConst.error),
                        );
                      }
                    },
                  ),
                  body: ListView(
                    children: [
                      SizedBox(
                        height: 416,
                        child: BlocConsumer<ImageCubit, ImageState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is ImageLoaded) {
                              if (state.images.isEmpty) {
                                return NoImageWidget();
                              }
                              imageMax = state.images.length;
                              return Column(
                                children: [
                                  Container(
                                    height: 400,
                                    color: Colors.black12,
                                    child: PageView.builder(
                                      itemCount: state.images.length,
                                      pageSnapping: true,
                                      itemBuilder: (context, pagePosition) {
                                        return InkWell(
                                          onTap: () {
                                            zoomDialog(
                                                state.images[widget.idAd]![
                                                    pagePosition],
                                                context);
                                          },
                                          child: Image.memory(
                                            Uint8List.fromList(state.images[
                                                widget.idAd]![pagePosition]),
                                          ),
                                        );
                                      },
                                      onPageChanged: (pagePosition) {
                                        setState(() {
                                          imageCount = pagePosition + 1;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                    child: Center(
                                      child: Text("$imageCount/$imageMax",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state is ImageLoadingFailure) {
                              return TryAgainWidget(
                                exception: state.exception,
                                onPressed: () {
                                  _imageBloc.loadImages(widget.idAd, false);
                                },
                              );
                            }
                            return ShimmeringContainer();
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: Markup.padding_h_24_t_16_b_4,
                            child: Text(state.ad.title,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text("${state.ad.price} ${SC.RUBLES}",
                                      style:
                                          Theme.of(context).textTheme.labelLarge),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final chatId = await chatService.startChat(
                                      state.ad, token);
                                  context.push("/chat/$chatId");
                                },
                                child: Expanded(
                                  child: Text("Написать",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: Markup.padding_h_16_t_4_b_16,
                            child: Text(state.ad.created,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: Markup.padding_h_16_t_4_b_16,
                                  child: Text("${state.ad.views} просмотров",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                ),
                              ),
                              Markup.dividerW10,
                              Expanded(
                                child: MiniProfile(user: state.ad.user),
                              )
                            ],
                          ),
                          Container(
                            padding: Markup.padding_l_16_t_24_b_2,
                            child: Text("Описание:",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 60,
                              ),
                              Expanded(
                                child: Container(
                                    padding: Markup.padding_all_8,
                                    child: Text(state.ad.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium)),
                              ),
                            ],
                          ),
                          /*Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Позвонить",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge),
                                ),
                              ),
                              Markup.dividerW10,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final chatId = await chatService.startChat(
                                        state.ad, token);
                                    context.push("/chat/$chatId");
                                  },
                                  child: Text("Написать",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge),
                                ),
                              ),
                            ],
                          )*/
                        ],
                      ),
                    ],
                  ),
                );
              }
              if (state is AdLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _adBloc.loadAd(id: widget.idAd, token: token);
                  },
                );
              }
              return ShimmeringContainer();
            },
          ),
        ),
      ),
    );
  }
}

Future<void> zoomDialog(List<int> image, BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              panEnabled: false,
              minScale: 1,
              maxScale: 4,
              child: Image.memory(
                Uint8List.fromList(image),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
