import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fixnum/fixnum.dart';

import '../../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../data/repository/ad_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../generated/user.pb.dart';
import '../../values/values.dart';
import '../../widgets/custom_grid.dart';
import '../../widgets/widgets.dart';
import '../main/widget/ad_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.id});

  final Int64 id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var userRepository = GetIt.I<UserRepository>();
  final _adListBloc = AdListBloc(
    GetIt.I<AdRepository>(),
    GetIt.I<UserRepository>(),
  );

  final _userBloc = UserBloc(
    GetIt.I<UserRepository>(),
  );

  @override
  void initState() {
    _userBloc.add(LoadUser(widget.id));
    _adListBloc.add(LoadUserAd(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthNow = Markup.widthNow(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _adListBloc.add(LoadUserAd(widget.id));
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<UserBloc, UserState>(
                bloc: _userBloc,
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 250,
                        child: Padding(
                          padding: Markup.padding_all_8,
                          child: Column(
                            children: [
                              Padding(
                                padding: Markup.padding_all_16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.memory(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                    Uint8List.fromList(state.user.avatar),
                                  ),
                                ),
                              ),
                              Text(state.user.name,
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(state.user.address,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(state.user.phone,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Markup.dividerH5,
                              const Divider(height: 3),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is UserLoadingFailure) {
                    return SliverFillRemaining(
                      child: TryAgainWidget(
                        exception: state.exception,
                        onPressed: () {
                          _adListBloc.add(LoadUserAd(widget.id));
                        },
                      ),
                    );
                  }
                  return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()));
                },
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
                                style: Theme.of(context).textTheme.bodyMedium),
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
                          _adListBloc.add(LoadUserAd(widget.id));
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
