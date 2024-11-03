import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/headers/ad_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/service/chat_service.dart';
import '../../widgets/mini_profile.dart';
import '../../widgets/try_again.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key, required this.idAd});

  final String idAd;

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  final chatService = GetIt.I<ChatService>();

  late final _adBloc = AdCubit.get(context);

  bool isFav = false;
  int imageCount = 1;

  @override
  void initState() {
    _adBloc.loadAd(id: widget.idAd);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: SafeArea(
        child: BlocBuilder<AdCubit, AdState>(
          bloc: _adBloc,
          builder: (context, state) {
            if (state is AdLoaded) {
              return Scaffold(
                  appBar: adHeader(
                    state.ad.isFav,
                    () async {
                      await _adBloc.setFavorite(state.ad.id);
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
                        height: 421,
                        child: Column(children: [
                          Container(
                            height: 400,
                            color: Colors.black12,
                            child: PageView.builder(
                              itemCount: state.ad.images.length,
                              pageSnapping: true,
                              itemBuilder: (context, pagePosition) {
                                return InkWell(
                                  onTap: () {
                                    zoomDialog(
                                        state.ad.images[pagePosition]
                                            .toString(),
                                        context);
                                  },
                                  child: Image.network(
                                    height: 400,
                                    "${Const.image_api}${state.ad.images[pagePosition]}",
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
                          Text("$imageCount из ${state.ad.images.length}",
                              style: Theme.of(context).textTheme.labelSmall)
                        ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: Markup.padding_h_16_v_4,
                            child: Text(state.ad.title,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text("${state.ad.price} ${SC.RUBLES}",
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final chatId =
                                      await chatService.startChat(state.ad);
                                  context.push("/chat/$chatId");
                                },
                                child: const Text("Написать"),
                              ),
                            ],
                          ),
                          Container(
                            padding: Markup.padding_h_16_t_4_b_16,
                            child: Text(state.ad.created,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          MiniProfile(user: state.ad.user),
                          Container(
                            padding: Markup.padding_h_16_t_4_b_16,
                            child: Text("${state.ad.views} просмотров",
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                          Container(
                            padding: Markup.padding_l_16_t_24_b_2,
                            child: Text(state.ad.category.name,
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                          Container(
                            padding: Markup.padding_l_16_t_24_b_2,
                            child: Text("Описание:",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                          Container(
                              padding: Markup.padding_all_8,
                              child: Text(state.ad.description,
                                  style:
                                      Theme.of(context).textTheme.labelMedium)),
                        ],
                      ),
                    ],
                  ));
            }
            if (state is AdLoadingFailure) {
              return Center(
                child: TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _adBloc.loadAd(id: widget.idAd);
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Future<void> zoomDialog(String image, BuildContext context) async {
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
              child: Image.network("${Const.image_api}$image"),
            ),
          ),
        ],
      ),
    ),
  );
}
