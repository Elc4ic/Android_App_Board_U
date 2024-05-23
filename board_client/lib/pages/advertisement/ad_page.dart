import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/headers/ad_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/ad_bloc/ad_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../generated/ad.pb.dart';
import '../../widgets/footers/navigation_bar.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key, required this.id});

  final int id;

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  final _adBloc = AdBloc(
    GetIt.I<AdRepository>(),
  );

  @override
  void initState() {
    _adBloc.add(LoadAd(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc, AdState>(
      bloc: _adBloc,
      builder: (context, state) {
        if (state is AdLoaded) {
          return Scaffold(
            appBar: adHeader(false),
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    color: Colors.blue,
                    height: 400,
                  ),
                  Padding(
                    padding: Markup.padding_all_16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Styles.TitleText32("${state.ad.price}P"),
                        Styles.TitleText24(state.ad.title),
                        Styles.TitleText24("Описание: "),
                        Styles.Text24(state.ad.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is AdLoadingFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.exception.toString()),
                const Text('Please try againg later'),
                TextButton(
                  onPressed: () {
                    _adBloc.add(LoadAd(id: widget.id));
                  },
                  child: const Text('Try againg'),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
