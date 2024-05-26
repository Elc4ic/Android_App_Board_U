import 'package:board_client/pages/favorite/widget/row_card.dart';
import 'package:board_client/widgets/footers/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';
import '../login/login_redirect_page.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  final _adListBloc = AdListBloc(
    GetIt.I<AdRepository>(),
    GetIt.I<UserRepository>(),
  );

  @override
  void initState() {
    _adListBloc.add(LoadFavAd());
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
                if (state.adList.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Styles.Text16(SC.SEARCH_NOTHING),
                    ),
                  );
                }
                return ListView.builder(
                    padding: Markup.padding_all_4,
                    itemCount: state.adList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RowCard(ad: state.adList[index]);
                    });
              }
              if (state is AdListLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _adListBloc.add(LoadFavAd());
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
