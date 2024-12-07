import 'dart:async';

import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/pages/favorite/widget/row_card.dart';
import 'package:board_client/widgets/try_again.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../cubit/fav_cubit/fav_cubit.dart';
import '../../data/service/user_service.dart';
import '../../values/values.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  var userService = GetIt.I<UserService>();
  final ScrollController scrollController = ScrollController();

  late final _favBloc = FavCubit.get(context);

  @override
  void initState() {
    _favBloc.fetchFavsHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Избранное", style: Theme.of(context).textTheme.labelLarge),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _favBloc.fetchFavsHistory();
          },
          child: BlocBuilder<FavCubit, FavState>(
            bloc: _favBloc,
            builder: (context, state) {
              if (state is FavLoaded) {
                if (state.favs.isEmpty) {
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
                  itemCount: state.favs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RowCard(
                      ad: state.favs[index],
                      token: userService.getToken(),
                    );
                  },
                );
              }
              if (state is FavLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _favBloc.fetchFavsHistory();
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
