import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/cubit/category_cubit/category_cubit.dart';
import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/pages/main/widget/ad_card.dart';
import 'package:board_client/widgets/custom_grid.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';

import '../../data/service/category_service.dart';
import '../../data/service/user_service.dart';
import '../../generated/ad.pb.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var userService = GetIt.I<UserService>();
  final _scrollController = ScrollController();

  late final _adListBloc = AdListCubit(GetIt.I<AdService>(),GetIt.I<UserService>());
  late final _catListBloc = CategoryCubit.get(context);
  late final _imageBloc = ImageCubit.get(context);

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _adListBloc.getAdList(true);
      _catListBloc.loadCategories();
    });
    _scrollController.addListener(() async {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 100.0;
      if (maxScroll - currentScroll <= delta && _adListBloc.isLoading) {
        _adListBloc.isLoading = true;
        _adListBloc.page++;
        await Future.delayed(const Duration(milliseconds: 500), () {
          _adListBloc.getAdList(false);
        });
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _catListBloc.close();
    _adListBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthNow = Markup.widthNow(context);
    return SafeArea(
      child: Scaffold(
        appBar: header(context, _adListBloc),
        body: RefreshIndicator(
          onRefresh: () async {
            _adListBloc.page = 0;
            _adListBloc.getAdList(true);
            _catListBloc.loadCategories();
          },
          child: CustomScrollView(
            cacheExtent: Const.cardCacheExtent,
            physics: const ClampingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<CategoryCubit, CategoryState>(
                    bloc: _catListBloc,
                    builder: (context, state) {
                      if (state is CategoryLoaded) {
                        return SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: generateCategory(
                                state.categories, context, _adListBloc),
                          ),
                        );
                      }
                      if (state is CategoryFailure) {
                        return Center(
                          child: TryAgainWidget(
                            exception: state.exception,
                            onPressed: () {
                              _catListBloc.loadCategories();
                            },
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              BlocBuilder<AdListCubit, AdListState>(
                bloc: _adListBloc,
                builder: (context, state) {
                  if (state is AdListLoaded) {
                    _adListBloc.isLoading = (state.hasMore) ? false : true;
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
                              token: userService.getToken())).toList(),
                    );
                  }
                  if (state is AdListLoadingFailure) {
                    return SliverFillRemaining(
                      child: TryAgainWidget(
                        exception: state.exception,
                        onPressed: () {
                          _adListBloc.getAdList(false);
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
    );
  }
}

List<Widget> generateCategory(
    List<Category> categories, BuildContext context, AdListCubit adListBloc) {
  return List.generate(
    categories.length,
    (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
          onPressed: () {
            adListBloc.page = 0;
            adListBloc.category = categories[index];
            adListBloc.getAdList(true);
          },
          child: Text(categories[index].name,
              style: Theme.of(context).textTheme.bodySmall)),
    ),
  ).toList();
}

PreferredSizeWidget header(BuildContext context, AdListCubit adListBloc) {
  final searchController = TextEditingController();
  searchController.text = adListBloc.search;
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
                adListBloc.search = value;
              },
              onSubmitted: (String value) {
                adListBloc.page = 0;
                adListBloc.getAdList(true);
              },
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                  tooltip: "Фильтрация",
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () => filterDialog(context, adListBloc,
                      adListBloc.page, AdListCubit.pageSize),
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
    BuildContext context, AdListCubit cubit, int page, int pageSize) async {
  final formKey = GlobalKey<FormState>();
  final maxController = TextEditingController();
  final minController = TextEditingController();
  final addressController = TextEditingController();
  minController.text = cubit.priceMin == 0 ? "" : cubit.priceMin.toString();
  maxController.text = cubit.priceMax == 0 ? "" : cubit.priceMax.toString();
  addressController.text = cubit.address;
  final categoryService = GetIt.I<CategoryService>();
  List<Category>? categories = categoryService.getCategories();
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
                  cubit.category = newValue;
                },
                value: cubit.category,
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
                  cubit.query = newValue!;
                },
                value: cubit.query,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      cubit.page = 0;
                      cubit.priceMax = 0;
                      cubit.priceMin = 0;
                      cubit.address = "";
                      cubit.category = null;
                      cubit.getAdList(true);
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
                          cubit.priceMax = int.parse(maxController.text);
                        }
                        if (minController.text.isNotEmpty) {
                          cubit.priceMin = int.parse(minController.text);
                        }
                        cubit.address =
                            Markup.capitalize(addressController.text);
                        cubit.getAdList(true);
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
