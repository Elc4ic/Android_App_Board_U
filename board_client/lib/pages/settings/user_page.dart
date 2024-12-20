import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/chat_service.dart';
import 'package:board_client/widgets/service_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/user_ad_cubit/user_ad_cubit.dart';
import '../../data/service/ad_service.dart';
import '../../data/service/user_service.dart';
import '../../values/values.dart';
import '../../widgets/custom_grid.dart';
import '../../widgets/mini_profile.dart';
import '../../widgets/try_again.dart';
import '../main/widget/ad_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.id});

  final String id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final _userAdBloc = UserAdCubit.get(context);
  late final _userBloc = UserCubit(GetIt.I<UserService>());

  @override
  void initState() {
    _userBloc.loadUser(widget.id);
    _userAdBloc.getUserList(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    _userAdBloc.close();
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthNow = Markup.widthNow(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _userBloc.loadUser(widget.id);
            _userAdBloc.getUserList(widget.id);
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<UserCubit, UserState>(
                bloc: _userBloc,
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return SliverToBoxAdapter(
                      child: Profile(
                        user: state.user,
                        own: false,
                        child: Column(
                          children: [
                            ServicePanel(
                              onTap: () => context
                                  .push("${SC.COMMENT_PAGE}/${widget.id}"),
                              title: "Комментарии",
                              icon: Icons.connect_without_contact,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is UserLoadingFailure) {
                    return SliverFillRemaining(
                      child: TryAgainWidget(
                        exception: state.exception,
                        onPressed: () {
                          _userBloc.loadUser(widget.id);
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
              BlocBuilder<UserAdCubit, UserAdState>(
                bloc: _userAdBloc,
                builder: (context, state) {
                  if (state is UserAdLoaded) {
                    if (state.userAds.isEmpty) {
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
                          state.userAds.length,
                          (index) => AdCard(
                              ad: state.userAds[index],
                              token: _userBloc.getToken())).toList(),
                    );
                  }
                  if (state is UserAdLoadingFailure) {
                    return SliverFillRemaining(
                      child: TryAgainWidget(
                        exception: state.exception,
                        onPressed: () {
                          _userAdBloc.getUserList(widget.id);
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
