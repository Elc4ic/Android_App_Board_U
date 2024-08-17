import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
              child: SizedBox(
                height: 260,
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
                            Uint8List.fromList(user!.avatar),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push("${SC.COMMENT_PAGE}/${user.id}");
                        },
                        child: RatingBar.builder(
                          initialRating: user.ratingAll / user.ratingNum,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                      Text(user.name,
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(user.address,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(user.phone,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Markup.dividerH5,
                      const Divider(height: 3),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: Markup.padding_h_8,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => changeDialog(context),
                        child: Text("Изменить имя",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => avatarDialog(context),
                        child: Text("Изменить аватар",
                            style: Theme.of(context).textTheme.bodyMedium),
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
                          userRepository.logout();
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
                    await userRepository.changeUser(
                        user, userRepository.getToken());
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
