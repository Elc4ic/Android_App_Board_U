import 'package:board_client/pages/favorite/widget/row_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  var userRepository = GetIt.I<UserRepository>();

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
      appBar: AppBar(
        title: Text("Избранное",
            style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _adListBloc.add(LoadFavAd());
          },
          child: BlocBuilder<AdListBloc, AdListState>(
            bloc: _adListBloc,
            builder: (context, state) {
              if (state is AdListLoaded) {
                if (state.adList.isEmpty) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(SC.SEARCH_NOTHING,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return ListView.builder(
                  padding: Markup.padding_all_4,
                  itemCount: state.adList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RowCard(
                      ad: state.adList[index],
                      token: userRepository.getToken(),
                    );
                  },
                );
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
