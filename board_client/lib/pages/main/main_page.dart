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
import '../../generated/ad.pb.dart';

String commonSearch = "";
int? priceMax;
int? priceMin;
String commonAddress = "";
Category? commonCategory;
int page = 0;
const pageSize = 10;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
    Future.delayed(const Duration(seconds: 1), () {
      _adListBloc.add(LoadAdList(
          commonSearch,
          commonAddress,
          priceMax ?? 1000000,
          priceMin ?? 0,
          page,
          pageSize,
          true,
          commonCategory));
      _catListBloc.add(LoadCategories());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthNow = Markup.widthNow(context);
    return SafeArea(
      child: Scaffold(
        appBar: header(context, _adListBloc),
        body: SelectionArea(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                page = 0;
              });
              _adListBloc.add(LoadAdList(
                  commonSearch,
                  commonAddress,
                  priceMax ?? 1000000,
                  priceMin ?? 0,
                  page,
                  pageSize,
                  true,
                  commonCategory));
              _catListBloc.add(LoadCategories());
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<CategoryListBloc, CategoryListState>(
                    bloc: _catListBloc,
                    builder: (context, state) {
                      if (state is CategoryListLoaded) {
                        return Wrap(
                          spacing: 5,
                          children: generateCategory(
                              state.categories, context, _adListBloc),
                        );
                      }
                      if (state is CategoryFailure) {
                        return Center(
                          child: TryAgainWidget(
                            exception: state.exception,
                            onPressed: () {},
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
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
                              child: Text(SC.SEARCH_NOTHING,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                        );
                      }
                      return CustomGrid(
                        cellWidth: Const.cellWidthInt,
                        width: widthNow,
                        items: List.generate(
                            state.adList.length,
                            (index) => AdCard(
                                ad: state.adList[index],
                                token: userRepository.getToken())).toList(),
                      );
                    }
                    if (state is AdListLoadingFailure) {
                      return SliverFillRemaining(
                        child: TryAgainWidget(
                          exception: state.exception,
                          onPressed: () {
                            _adListBloc.add(LoadAdList(
                                commonSearch,
                                commonAddress,
                                priceMax ?? 1000000,
                                priceMin ?? 0,
                                page,
                                pageSize,
                                false,
                                commonCategory));
                          },
                        ),
                      );
                    }
                    return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()));
                  },
                ),
                SliverToBoxAdapter(
                    child: ElevatedButton(
                  child: Text("Загрузить",
                      style: Theme.of(context).textTheme.bodySmall),
                  onPressed: () {
                    setState(() {
                      page++;
                    });
                    _adListBloc.add(LoadAdList(
                        commonSearch,
                        commonAddress,
                        priceMax ?? 1000000,
                        priceMin ?? 0,
                        page,
                        pageSize,
                        false,
                        commonCategory));
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> generateCategory(
    List<Category> categories, BuildContext context, AdListBloc adListBloc) {
  return List.generate(
    categories.length,
    (index) => ElevatedButton(
        onPressed: () {
          commonCategory = categories[index];
          adListBloc.add(LoadAdList(
              commonSearch,
              commonAddress,
              priceMax ?? 10000000,
              priceMin ?? 0,
              page,
              pageSize,
              true,
              commonCategory));
        },
        child: Text(categories[index].name,
            style: Theme.of(context).textTheme.bodySmall)),
  ).toList();
}

PreferredSizeWidget header(BuildContext context, AdListBloc adListBloc) {
  final searchController = TextEditingController();
  searchController.text = commonSearch;
  return PreferredSize(
    preferredSize: const Size.fromHeight(Const.HeaderHight),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: Markup.padding_all_8,
            child: SearchBar(
              controller: searchController,
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                commonSearch = value;
              },
              onSubmitted: (String value) {
                adListBloc.add(LoadAdList(
                    commonSearch,
                    commonAddress,
                    priceMax ?? 1000000,
                    priceMin ?? 0,
                    page,
                    pageSize,
                    true,
                    commonCategory));
              },
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                  tooltip: "Фильтрация",
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () =>
                      filterDialog(context, adListBloc, page, pageSize),
                ),
              ],
              hintText: SC.SEARCH_HINT,
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> filterDialog(
    BuildContext context, AdListBloc adListBloc, int page, int pageSize) async {
  final maxController = TextEditingController();
  final minController = TextEditingController();
  final addressController = TextEditingController();
  maxController.text = priceMax.toString();
  minController.text = priceMin.toString();
  addressController.text = commonAddress;
  final categoryRepository = GetIt.I<CategoryRepository>();
  List<Category>? categories = categoryRepository.getCategories();
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        height: 350,
        child: Column(
          children: [
            Text("Цена", style: Theme.of(context).textTheme.titleMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "от",
                    ),
                  ),
                ),
                Markup.dividerW10,
                Expanded(
                  child: TextFormField(
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "до",
                    ),
                  ),
                ),
              ],
            ),
            Markup.dividerH10,
            Text("Адрес", style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "адрес",
              ),
            ),
            DropdownButtonFormField(
              items: categories?.map((Category category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (newValue) {
                commonCategory = newValue;
              },
              value: commonCategory,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    priceMax = int.parse(maxController.text);
                    priceMin = int.parse(minController.text);
                    commonAddress = addressController.text;
                    adListBloc.add(LoadAdList(
                        commonSearch,
                        commonAddress,
                        priceMax ?? 10000000,
                        priceMin ?? 0,
                        page,
                        pageSize,
                        true,
                        commonCategory));
                    Navigator.pop(context);
                  },
                  child: Text("Ок",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
