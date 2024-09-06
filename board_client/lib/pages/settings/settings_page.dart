import 'package:board_client/widgets/mini_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixnum/fixnum.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final userRepository = GetIt.I<UserRepository>();
  Int64? userId;
  final _userBloc = UserBloc(
    GetIt.I<UserRepository>(),
  );

  @override
  void initState(){
    userId = userRepository.getUser()!.id;
    _userBloc.add(LoadUser(userId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _userBloc.add(LoadUser(userId!));
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<UserBloc, UserState>(
                bloc: _userBloc,
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return SliverToBoxAdapter(
                      child: Profile(user: state.user),
                    );
                  }
                  if (state is UserLoadingFailure) {
                    return SliverFillRemaining(
                      child: TryAgainWidget(
                        exception: state.exception,
                        onPressed: () {
                          _userBloc.add(LoadUser(userId!));
                        },
                      ),
                    );
                  }
                  return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()));
                },
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: Markup.padding_h_8,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => changeDialog(context),
                                child: Text("Изменить имя",
                                    style: Theme.of(context).textTheme.bodyMedium),
                              ),
                            ),
                            Markup.dividerW10,
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => avatarDialog(context),
                                child: Text("Изменить аватар",
                                    style: Theme.of(context).textTheme.bodyMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push("/setaddress");
                          },
                          child: Text("Настроить адресс",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push("/usercomments");
                          },
                          child: Text("Отправленные комментарии",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            userRepository.logout(userId!);
                          },
                          child: Text("Выйти из аккаунта",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> changeDialog(BuildContext context) async {
  final userRepository = GetIt.I<UserRepository>();
  final nameController = TextEditingController();
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Введите новое имя",
                style: Theme.of(context).textTheme.bodyMedium),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Имя",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var user = userRepository.getUser();
                    user?.name = nameController.text;
                    await userRepository.changeUser(user);
                    context.pop();
                  },
                  child:
                      Text("Ок", style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> avatarDialog(BuildContext context) async {
  final userRepository = GetIt.I<UserRepository>();
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Выберите новый аватар",
                style: Theme.of(context).textTheme.bodyMedium),
            Padding(
              padding: Markup.padding_all_16,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2)),
                child: InkWell(
                  onTap: () async {
                    final picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      var user = userRepository.getUser();
                      var image = await NavItems.imageFromFile(picked);
                      user?.avatar = await NavItems.avatarToWebp(image);
                      await userRepository.changeUser(user);
                    }
                    context.pop();
                  },
                  child: const Center(
                    child: Icon(Icons.file_download_sharp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
