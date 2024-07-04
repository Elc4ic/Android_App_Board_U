import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/user_repository.dart';
import '../../values/values.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final userRepository = GetIt.I<UserRepository>();

  @override
  Widget build(BuildContext context) {
    final user = userRepository.getUser();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.memory(
                    fit: BoxFit.fitWidth,
                    Uint8List.fromList(user?.avatar ?? [1, 1]),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Styles.Text16("Имя: ${user?.name}"),
                  Markup.dividerW5,
                  Styles.Text16("Логин: ${user?.username}"),
                  Markup.dividerW5,
                  Styles.Text16("Телефон: ${user?.phone}"),
                  Markup.dividerW5,
                  Styles.Text16("Адресс: ${user?.address}"),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () => changeDialog(context),
                child: Styles.Text16("Изменить имя"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () => avatarDialog(context),
                child: Styles.Text16("Изменить аватар"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  context.push("/setaddress");
                },
                child: Styles.Text16("Настроить адресс"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  userRepository.logout();
                },
                child: Styles.Text16("logout"),
              ),
            ),
          ],
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
            Styles.Text16("Введите новое имя"),
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
                    await userRepository.changeUser(
                        user, userRepository.getToken());
                    context.pop();
                  },
                  child: Styles.Text16("Ок"),
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
            Styles.Text16("Выберите новый аватар"),
            Padding(
              padding: Markup.padding_all_16,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2)),
                child: InkWell(
                  onTap: () async {
                    final picked = await ImagePicker().pickImage(
                        source: ImageSource.gallery, imageQuality: 40);
                    if (picked != null) {
                      var user = userRepository.getUser();
                      var image = await NavItems.imageFromFile(picked);
                      user?.avatar = await NavItems.avatarToWebp(image);
                      await userRepository.changeUser(
                          user, userRepository.getToken());
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
