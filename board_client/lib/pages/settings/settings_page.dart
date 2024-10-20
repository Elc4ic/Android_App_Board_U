import 'dart:io';

import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/widgets/mini_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../values/values.dart';
import '../../widgets/widgets.dart';
import '../advertisement/widget/my_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final _userBloc = UserCubit.get(context);

  @override
  void initState() {
    _userBloc.initId();
    _userBloc.loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _userBloc.loadUser();
        },
        child: CustomScrollView(
          slivers: [
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {},
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
                        _userBloc.loadUser();
                      },
                    ),
                  );
                }
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => changeDialog(context, _userBloc),
                            child: Text("Изменить имя",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => avatarDialog(context, _userBloc),
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
                  const SizedBox(
                    width: double.infinity,
                    height: 50,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => myDialog(context, () async {
                            await _userBloc.logOut();
                            exit(0);
                          }, "Выход из аккаунта закроет приложение!"),
                          child: Text("Выйти из аккаунта",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => myDialog(context, () async {
                            _userBloc.deleteUser();
                            exit(0);
                          }, "Удаление аккаунта закроет приложение!"),
                          child: Text("Удалить аккаунт",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> changeDialog(BuildContext context, UserCubit userBloc) async {
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
                    var user = userBloc.getUser();
                    user?.name = nameController.text;
                    await userBloc.changeUser(user);
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

Future<void> avatarDialog(BuildContext context, UserCubit userBloc) async {
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
                      var user = userBloc.getUser();
                      var image = await NavItems.imageFromFile(picked);
                      user?.avatar = await NavItems.avatarToWebp(image);
                      await userBloc.changeUser(user);
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
