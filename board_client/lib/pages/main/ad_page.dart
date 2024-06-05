import 'dart:typed_data';

import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/headers/ad_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/ad_bloc/ad_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../widgets/widgets.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key, required this.id});

  final int id;

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  final adRepository = GetIt.I<AdRepository>();
  final userRepository = GetIt.I<UserRepository>();

  final _adBloc = AdBloc(
    GetIt.I<AdRepository>(),
  );

  @override
  void initState() {
    _adBloc.add(LoadAd(id: widget.id));
    super.initState();
  }
  bool isFav = false;

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
                  isFav,
                  () async {
                    await adRepository.setFavoriteAd(
                        state.ad.id, userRepository.getToken());
                    setState(
                      () {
                        isFav = !isFav;
                      },
                    );
                  },
                ),
                body: ListView(
                  children: [
                    Container(
                      color: Colors.blue,
                      height: 400,
                      child: Image.memory(Uint8List.fromList(state.ad.images.first.image)),
                    ),
                    Padding(
                      padding: Markup.padding_all_16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Styles.TitleText32("${state.ad.price} ${SC.RUBLES}"),
                          Styles.TitleText24(state.ad.title),
                          Styles.TitleText24("Описание: "),
                          Styles.Text24(state.ad.description),
                          Markup.dividerW10,
                          Styles.Text24(state.ad.user.username),
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
                  _adBloc.add(LoadAd(id: widget.id));
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
