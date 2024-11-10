import 'dart:io';

import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/widgets/mini_profile.dart';
import 'package:board_client/widgets/service_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../values/values.dart';
import '../advertisement/widget/my_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final _userBloc = UserCubit.get(context);
  late User user = _userBloc.getUser();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _userBloc.loadUser(user.id);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Profile(
                    own: true,
                    user: user,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ServicePanel(
                            onTap: () => changeDialog(context, _userBloc),
                            title: "Изменить имя",
                            icon: Icons.accessibility_new),
                        ServicePanel(
                            onTap: () => avatarDialog(context, _userBloc),
                            title: "Изменить аватар",
                            icon: Icons.account_box),
                        ServicePanel(
                            onTap: () => context.push("/setaddress"),
                            title: "Настроить адресс",
                            icon: Icons.home),
                        Text("  Комментарии",
                            style: Theme.of(context).textTheme.titleSmall),
                        ServicePanel(
                            onTap: () => context.push("/usercomments"),
                            title: "Полученные",
                            icon: Icons.comment),
                        ServicePanel(
                            onTap: () =>
                                context.push("${SC.COMMENT_PAGE}/${user.id}"),
                            title: "Отправленные",
                            icon: Icons.connect_without_contact),
                        Text("  Настройки",
                            style: Theme.of(context).textTheme.titleSmall),
                        ServicePanel(
                            onTap: () => myDialog(context, () async {
                                  await _userBloc.logOut();
                                  exit(0);
                                }, "Выход из аккаунта закроет приложение!"),
                            title: "Выйти из аккаунта",
                            icon: Icons.exit_to_app),
                        ServicePanel(
                            onTap: () => myDialog(context, () async {
                                  _userBloc.deleteUser();
                                  exit(0);
                                }, "Удаление аккаунта закроет приложение!"),
                            title: "Удалить аккаунт",
                            icon: Icons.delete),
                      ],
                    ),
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
                    user.name = nameController.text;
                    await userBloc.changeUser(user);
                    context.pop();
                  },
                  child: Text("Ок"),
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
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.onSurface),
                ),
                child: InkWell(
                  onTap: () async {
                    final picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      var image = await NavItems.imageFromFile(picked);
                      image = await NavItems.avatarToWebp(image);
                      await userBloc.changeAvatar(image);
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
