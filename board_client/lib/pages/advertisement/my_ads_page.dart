import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/pages/advertisement/widget/myad_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/service/ad_service.dart';
import '../../data/service/user_service.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  var userService = GetIt.I<UserService>();

  late final _adListBloc =
      AdListCubit(GetIt.I<AdService>(), GetIt.I<UserService>());

  @override
  void initState() {
    _adListBloc.getMyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои объявления",
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: SelectionArea(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              _adListBloc.getMyList();
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
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: state.adList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.adList.length) {
                        return const SizedBox(height: 80);
                      }
                      return AdRow(
                        ad: state.adList[index],
                        token: userService.getToken(),
                        adListBloc: _adListBloc,
                      );
                    },
                  );
                }
                if (state is AdListLoadingFailure) {
                  return TryAgainWidget(
                    exception: state.exception,
                    onPressed: () {
                      _adListBloc.getMyList();
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(SC.ADD_PAGE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
