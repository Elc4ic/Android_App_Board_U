import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/routing/not_found_page.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/headers/ad_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
          builder: (contextB, state) {
            if (state is AdLoaded) {
              return Scaffold(
                appBar: adHeader(
                  state.ad.isFav,
                  widget.idAd,
                ),
                body: ListView(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Stack(
                        children: [
                          Expanded(
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(30),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: Markup.padding_all_16,
                              child: Text(
                                "$imageCount из ${state.ad.images.length}",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: Markup.padding_all_16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.ad.title,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text("${state.ad.price} ${SC.RUBLES}",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(state.ad.user.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)
                                ],
                              ),
                              Row(children: [
                                Text("Категория: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey)),
                                Text(state.ad.category.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                              ])
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: Markup.padding_all_16,
                          child: Text(state.ad.description,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Divider(),
                        MiniProfile(user: state.ad.user),
                        Divider(),
                        ElevatedButton(
                          onPressed: errorSnail(context, () async {
                            final chatId =
                                await chatService.startChat(state.ad);
                            context.push("/chat/$chatId");
                          }),
                          child: Container(
                            alignment: Alignment.center,
                              width: double.infinity,
                              child: Text("Написать")),
                        ),
                        Markup.dividerH10,
                        Container(
                          width: double.infinity,
                          padding: Markup.padding_all_16,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                              "Идендификатор: ${state.ad.id}\nДата публикации: ${state.ad.created}\nПросмотров: ${state.ad.views}",
                              style: Theme.of(context).textTheme.bodySmall),
                        )
                      ],
                    ),
                  ],
                ),
              );
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
