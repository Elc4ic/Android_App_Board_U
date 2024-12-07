import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/pages/advertisement/widget/myad_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/my_cubit/my_cubit.dart';
import '../../data/service/ad_service.dart';
import '../../data/service/user_service.dart';
import '../../values/values.dart';
import '../../widgets/try_again.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  late final _myBloc = MyCubit.get(context);

  @override
  void initState() {
    _myBloc.getMyList();
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
              _myBloc.getMyList();
            },
            child: BlocBuilder<MyCubit, MyState>(
              bloc: _myBloc,
              builder: (context, state) {
                if (state is MyLoaded) {
                  if (state.myAds.isEmpty) {
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
                    itemCount: state.myAds.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.myAds.length) {
                        return const SizedBox(height: 80);
                      }
                      return AdRow(
                        ad: state.myAds[index],
                        myBloc: _myBloc,
                      );
                    },
                  );
                }
                if (state is MyLoadingFailure) {
                  return TryAgainWidget(
                    exception: state.exception,
                    onPressed: () {
                      _myBloc.getMyList();
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
