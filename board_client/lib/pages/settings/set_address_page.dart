import 'package:board_client/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/user_repository.dart';

class SetAddressPage extends StatefulWidget {
  const SetAddressPage({super.key});

  @override
  State<SetAddressPage> createState() => _SetAddressPageState();
}

class _SetAddressPageState extends State<SetAddressPage> {
  final userRepository = GetIt.I<UserRepository>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? locf;
  String? campusf;
  String? gorodf;

  String? block;
  int step = 1;
  int type = 1;

  @override
  Widget build(BuildContext context) {
    String? loc;
    String? campus;
    String? gorod;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: Markup.padding_all_16,
            child: Column(
              children: [
                Visibility(
                  visible: step > 0,
                  child: DropdownButtonFormField(
                    items: Address.lc.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        loc = newValue;
                        locf = newValue;
                        if (loc == Address.lc[0]) {
                          type = 1;
                        } else if (loc == Address.lc[1]) {
                          type = 2;
                        } else {
                          type = 3;
                        }
                        step = 2;
                        campus = "";
                        gorod = "";
                        gorodf = "";
                        campusf = "";
                        block = "";
                      });
                    },
                    value: loc,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Markup.dividerH10,
                Visibility(
                  visible: step > 1 && type == 1,
                  child: DropdownButtonFormField(
                    items: Address.campus.map((String kor) {
                      return DropdownMenuItem(
                        value: kor,
                        child: Text(kor),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        campus = newValue;
                        campusf = newValue;
                        step = 3;
                        gorod = "";
                        gorodf = "";
                        block = "";
                      });
                    },
                    value: campus,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: step > 1 && type == 2,
                  child: DropdownButtonFormField(
                    items: Address.gorod.map((String kor) {
                      return DropdownMenuItem(
                        value: kor,
                        child: Text(kor),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        gorod = newValue;
                        gorodf = newValue;
                        campus = "";
                        campusf = "";
                        block = "";
                        step = 3;
                      });
                    },
                    value: gorod,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Markup.dividerH10,
                Visibility(
                  visible: step > 2,
                  child: TextFormField(
                    controller: _blockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Комната",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: step > 1 && type == 3,
                  child: TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Адрес",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    var user = userRepository.getUser();
                    user?.address = (type == 3)
                        ? _addressController.text
                        : "${locf ?? ""}: к.${campusf ?? ""}${gorodf ?? ""} ком.${_blockController.text}";
                    await userRepository.changeUser(
                        user, userRepository.getToken());
                    context.go(SC.SETTINGS_PAGE);
                  },
                  child: Text("Сохранить", style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
