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

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  var userRepository = GetIt.I<UserRepository>();

  final _adListBloc = AdListBloc(
    GetIt.I<AdRepository>(),
    GetIt.I<UserRepository>(),
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
          child: RefreshIndicator(
            onRefresh: () async {
              _adListBloc.add(LoadMyAd());
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
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
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
                        return AdRow(
                          ad: state.adList[index],
                          token: userRepository.getToken(),
                          adListBloc: _adListBloc,
                        );
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
