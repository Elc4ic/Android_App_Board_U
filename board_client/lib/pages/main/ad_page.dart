import 'dart:typed_data';

import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/headers/ad_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fixnum/fixnum.dart';

import '../../bloc/ad_bloc/ad_bloc.dart';
import '../../bloc/image_bloc/image_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../widgets/mini_profile.dart';
import '../../widgets/widgets.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key, required this.idAd});

  final Int64 idAd;

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  final adRepository = GetIt.I<AdRepository>();
  final chatRepository = GetIt.I<ChatRepository>();

  final _adBloc = AdBloc(
    GetIt.I<AdRepository>(),
  );

  final _imageBloc = ImageBloc(
    GetIt.I<AdRepository>(),
  );

  bool isFav = false;
  int imageCount = 1;
  int imageMax = 1;
  final String? token = GetIt.I<UserRepository>().getToken();

  @override
  void initState() {
    _adBloc.add(LoadAd(id: widget.idAd, token: token));
    _imageBloc.add(LoadImageList(widget.idAd, false, token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AdBloc, AdState>(
          bloc: _adBloc,
          builder: (context, state) {
            if (state is AdLoaded) {
              return Scaffold(
                appBar: adHeader(
                  state.ad.isFav,
                  () async {
                    await adRepository.setFavoriteAd(state.ad.id, token);
                    setState(
                      () {
                        isFav = !isFav;
                      },
                    );
                  },
                ),
                body: ListView(
                  children: [
                    SizedBox(
                      height: 412,
                      child: BlocBuilder<ImageBloc, ImageState>(
                        bloc: _imageBloc,
                        builder: (context, state) {
                          if (state is ImageLoaded) {
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
                                      return Image.memory(
                                        Uint8List.fromList(
                                            state.images[pagePosition]),
                                      );
                                    },
                                    onPageChanged: (pagePosition) {
                                      setState(() {
                                        imageCount = pagePosition +
                                            ((state.images.isEmpty) ? 1 : 0);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
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
                                _imageBloc.add(
                                    LoadImageList(widget.idAd, false, token));
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Padding(
                      padding: Markup.padding_h_8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.ad.price} ${SC.RUBLES}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(state.ad.title,
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Описание:",
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(state.ad.description,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Markup.dividerH10,
                          Text(state.ad.created,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Markup.dividerH10,
                          MiniProfile(user: state.ad.user),
                          Markup.dividerH10,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Позвонить",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ),
                              Markup.dividerW10,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final chatId = await chatRepository
                                        .startChat(state.ad, token);
                                    context.push("/chat/$chatId");
                                  },
                                  child: Text("Написать",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is AdLoadingFailure) {
              return TryAgainWidget(
                exception: state.exception,
                onPressed: () {
                  _adBloc.add(LoadAd(id: widget.idAd));
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
