import 'package:board_client/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MobileSearchHeader extends StatelessWidget {
  const MobileSearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(Markup.size_16)),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        tooltip: "Фильтрация",
                        icon: const Icon(Icons.filter_alt),
                        onPressed: () {
                          /* Clear the search field */
                        },
                      ),
                      hintText: SC.SEARCH_HINT,
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: IconButton(
                tooltip: "Запросы",
                icon: const Icon(Icons.task),
                onPressed: () => {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
