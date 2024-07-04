import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/pages/main/widget/ad_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/category_list_bloc/category_list_bloc.dart';
import '../../data/repository/category_repository.dart';
import '../../values/values.dart';
import '../../widgets/custom_grid.dart';
import '../../widgets/widgets.dart';
import 'main_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.categoryIndex});

  final int categoryIndex;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final catRepository = GetIt.I<CategoryRepository>();
  final _catListBloc = CategoryListBloc(GetIt.I<CategoryRepository>());
  late Category category;

  @override
  void initState() {
    category = catRepository.getCategories()![widget.categoryIndex];
    _catListBloc.add(LoadAdInCategory(category: category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthNow = Markup.widthNow(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Styles.Text24(category.name),
                ),
              ),
            ),
            BlocBuilder<CategoryListBloc, CategoryListState>(
              bloc: _catListBloc,
              builder: (context, state) {
                if (state is AdInCategoryLoaded) {
                  if (state.ads.isEmpty) {
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
                    items: List.generate(state.ads.length,
                        (index) => AdCard(ad: state.ads[index])).toList(),
                  );
                }
                if (state is CategoryFailure) {
                  return SliverFillRemaining(
                    child: TryAgainWidget(
                      exception: state.exception,
                      onPressed: () {
                        _catListBloc.add(
                          LoadAdInCategory(category: category),
                        );
                      },
                    ),
                  );
                }
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
