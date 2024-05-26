import 'package:board_client/pages/main/widget/ad_card.dart';
import 'package:board_client/widgets/custom_grid.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../bloc/category_list_bloc/category_list_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../data/repository/user_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.search});

  final String search;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var userRepository = GetIt.I<UserRepository>();
  final _adListBloc = AdListBloc(
    GetIt.I<AdRepository>(),
    GetIt.I<UserRepository>(),
  );
  final _catListBloc = CategoryListBloc(
    GetIt.I<CategoryRepository>(),
  );

  @override
  void initState() {
    _adListBloc.add(LoadAdList(widget.search));
    _catListBloc.add(LoadCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthNow = Markup.widthNow(context);
    return Scaffold(
      appBar: header,
      body: SelectionArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: BlocBuilder<CategoryListBloc, CategoryListState>(
                  bloc: _catListBloc,
                  builder: (context, state) {
                    if (state is CategoryListLoaded) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: NavItems.generateCategory(state.categories,context),
                      );
                    }
                    if (state is CategoryFailure) {
                      return Center(
                        child: TryAgainWidget(
                          exception: state.exception,
                          onPressed: () {
                            _adListBloc.add(LoadAdList(widget.search));
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            BlocBuilder<AdListBloc, AdListState>(
              bloc: _adListBloc,
              builder: (context, state) {
                if (state is AdListLoaded) {
                  if (state.adList.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: Center(
                          child: Styles.Text16(SC.SEARCH_NOTHING),
                        ),
                      ),
                    );
                  }
                  return CustomGrid(
                    cellWidth: 180,
                    width: widthNow,
                    items: List.generate(state.adList.length,
                        (index) => AdCard(ad: state.adList[index])).toList(),
                  );
                }
                if (state is AdListLoadingFailure) {
                  return SliverFillRemaining(
                    child: Center(
                      child: TryAgainWidget(
                        exception: state.exception,
                        onPressed: () {
                          _adListBloc.add(LoadAdList(widget.search));
                        },
                      ),
                    ),
                  );
                }
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
