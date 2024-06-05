import 'package:flutter/material.dart';

import '../../../values/values.dart';

Future<void> myDialog(BuildContext context,Function() function) async {
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 200,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Styles.Text16("Вы уверенны?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: function,
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
