import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/pages/favorite/widget/row_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/service/ad_service.dart';
import '../../data/service/user_service.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  var userService = GetIt.I<UserService>();

  late final _adListBloc = AdListCubit.get(context);

  @override
  void initState() {
    _adListBloc.getFavList();
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
            _adListBloc.getFavList();
          },
          child: BlocBuilder<AdListCubit, AdListState>(
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
                  cacheExtent: Const.cacheExtent,
                  itemCount: state.adList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RowCard(
                      ad: state.adList[index],
                      token: userService.getToken(),
                    );
                  },
                );
              }
              if (state is AdListLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _adListBloc.getFavList();
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
