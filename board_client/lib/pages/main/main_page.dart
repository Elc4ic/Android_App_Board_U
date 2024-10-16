import 'package:board_client/pages/main/widget/ad_card.dart';
import 'package:board_client/widgets/custom_grid.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../bloc/category_list_bloc/category_list_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../generated/ad.pb.dart';

String commonSearch = "";
int priceMax = 0;
int priceMin = 0;

String commonAddress = "";
Category? commonCategory;
String commonQuery = "По умолчанию";
int page = 0;
const pageSize = 10;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var userRepository = GetIt.I<UserRepository>();
  final _scrollController = ScrollController();
  final _adListBloc = AdListBloc(
    GetIt.I<AdRepository>(),
    GetIt.I<UserRepository>(),
  );
  final _catListBloc = CategoryListBloc(
    GetIt.I<CategoryRepository>(),
  );
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      _adListBloc.add(LoadAdList(commonSearch, commonAddress, priceMax,
          priceMin, page, pageSize, true, commonCategory, commonQuery));
      _catListBloc.add(LoadCategories());
    });
    _scrollController.addListener(() async {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 100.0;
      if (maxScroll - currentScroll <= delta && !_isLoading) {
        _isLoading = true;
        page++;
        await Future.delayed(const Duration(milliseconds: 500), () {
          _adListBloc.add(LoadAdList(commonSearch, commonAddress, priceMax,
              priceMin, page, pageSize, false, commonCategory, commonQuery));
        });
        setState(() {});
      }
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
              page = 0;
              _adListBloc.add(LoadAdList(commonSearch, commonAddress, priceMax,
                  priceMin, page, pageSize, true, commonCategory, commonQuery));
              _catListBloc.add(LoadCategories());
            },
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<CategoryListBloc, CategoryListState>(
                    bloc: _catListBloc,
                    builder: (context, state) {
                      if (state is CategoryListLoaded) {
                        return Column(
                          children: [
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: generateCategory(
                                  state.categories, context, _adListBloc),
                            ),
                            Markup.dividerH10,
                          ],
                        );
                      }
                      if (state is CategoryFailure) {
                        return Center(
                          child: TryAgainWidget(
                            exception: state.exception,
                            onPressed: () {
                              _catListBloc.add(LoadCategories());
                            },
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
                      _isLoading = (state.hasMore) ? false : true;
                      if (state.adList.isEmpty) {
                        return SliverFillRemaining(
                          child: SizedBox(
                            height: 200,
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
                                priceMax,
                                priceMin,
                                page,
                                pageSize,
                                false,
                                commonCategory,
                                commonQuery));
                          },
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
          page = 0;
          commonCategory = categories[index];
          adListBloc.add(LoadAdList(commonSearch, commonAddress, priceMax,
              priceMin, page, pageSize, true, commonCategory, commonQuery));
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
                page = 0;
                adListBloc.add(LoadAdList(
                    commonSearch,
                    commonAddress,
                    priceMax,
                    priceMin,
                    page,
                    pageSize,
                    true,
                    commonCategory,
                    commonQuery));
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
  final formKey = GlobalKey<FormState>();
  final maxController = TextEditingController();
  final minController = TextEditingController();
  final addressController = TextEditingController();
  minController.text = priceMin == 0 ? "" : priceMin.toString();
  maxController.text = priceMax == 0 ? "" : priceMax.toString();
  addressController.text = commonAddress;
  final categoryRepository = GetIt.I<CategoryRepository>();
  List<Category>? categories = categoryRepository.getCategories();
  List<String> query = Const.query;
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 320,
        height: 500,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text("Цена", style: Theme.of(context).textTheme.titleMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: minController,
                      keyboardType: TextInputType.number,
                      validator: MultiValidator(
                        [
                          PatternValidator(SC.NUM_PATTERN,
                              errorText: SC.NOT_NUM_ERROR),
                        ],
                      ).call,
                    ),
                  ),
                  Markup.dividerW10,
                  Expanded(
                    child: TextFormField(
                      controller: maxController,
                      keyboardType: TextInputType.number,
                      validator: MultiValidator(
                        [
                          PatternValidator(SC.NUM_PATTERN,
                              errorText: SC.NOT_NUM_ERROR),
                        ],
                      ).call,
                    ),
                  ),
                ],
              ),
              Markup.dividerH10,
              Text("Адрес", style: Theme.of(context).textTheme.titleMedium),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
              ),
              Markup.dividerH10,
              Text("Категория", style: Theme.of(context).textTheme.titleMedium),
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
              Markup.dividerH10,
              Text("Сортировка",
                  style: Theme.of(context).textTheme.titleMedium),
              DropdownButtonFormField(
                items: query.map((String orderBy) {
                  return DropdownMenuItem(
                    value: orderBy,
                    child: Text(orderBy),
                  );
                }).toList(),
                onChanged: (newValue) {
                  commonQuery = newValue!;
                },
                value: commonQuery,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      page = 0;
                      priceMax = 0;
                      priceMin = 0;
                      commonAddress = "";
                      commonCategory = null;
                      adListBloc.add(LoadAdList(
                          commonSearch,
                          commonAddress,
                          priceMax,
                          priceMin,
                          page,
                          pageSize,
                          true,
                          commonCategory,
                          commonQuery));
                      Navigator.pop(context);
                    },
                    child: Text("Сбросить",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        page = 0;
                        if (maxController.text.isNotEmpty) {
                          priceMax = int.parse(maxController.text);
                        }
                        if (minController.text.isNotEmpty) {
                          priceMin = int.parse(minController.text);
                        }
                        commonAddress =
                            Markup.capitalize(addressController.text);
                        adListBloc.add(LoadAdList(
                            commonSearch,
                            commonAddress,
                            priceMax,
                            priceMin,
                            page,
                            pageSize,
                            true,
                            commonCategory,
                            commonQuery));
                        Navigator.pop(context);
                      }
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
    ),
  );
}
