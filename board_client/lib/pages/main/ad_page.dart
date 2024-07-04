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
                      height: 420,
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
                                        imageCount = pagePosition + 1;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                  child: Center(
                                    child:
                                        Styles.Text12("$imageCount/$imageMax"),
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
                      padding: Markup.padding_all_8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Styles.TitleText24("${state.ad.price} ${SC.RUBLES}"),
                          Styles.TitleText24(state.ad.title),
                          Styles.TitleText16("Описание:"),
                          Styles.Text16(state.ad.description),
                          Markup.dividerH10,
                          Card(
                            child: InkWell(
                              onTap: () {
                                context
                                    .push("${SC.USER_PAGE}/${state.ad.user.id}");
                              },
                              child: Column(children: [
                                Styles.Text12("Адреc: ${state.ad.user.address}"),
                                Styles.Text12(
                                    "Пользователь: ${state.ad.user.name}"),
                              ]),
                            ),
                          ),
                          Markup.dividerH10,
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Styles.Text12("Позвонить"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final chatId = await chatRepository.startChat(
                                      state.ad, token);
                                  context.push("/chat/$chatId");
                                },
                                child: Styles.Text12("Написать"),
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
