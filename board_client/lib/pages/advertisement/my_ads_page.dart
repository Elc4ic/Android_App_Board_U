import 'package:board_client/pages/advertisement/widget/myad_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';
import '../login/login_redirect_page.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  final _adListBloc = AdListBloc(
    GetIt.I<AdRepository>()
  );

  @override
  void initState() {
    _adListBloc.add(LoadMyAd());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SafeArea(
          child: BlocBuilder<AdListBloc, AdListState>(
            bloc: _adListBloc,
            builder: (context, state) {
              if (state is AdListLoaded) {
                return ListView.builder(
                    padding: Markup.padding_all_4,
                    itemCount: state.adList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AdRow(ad: state.adList[index]);
                    });
              }
              if (state is AdListLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _adListBloc.add(LoadMyAd());
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { context.push(SC.ADD_PAGE); },
        child: const Icon(Icons.add),
      ),
    );
  }
}
