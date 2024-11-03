import 'package:flutter/material.dart';

Future<void> myDialog(
    BuildContext context, Function() function, String text) async {
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 240,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: function,
                  child:
                      const Text("Ок"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
