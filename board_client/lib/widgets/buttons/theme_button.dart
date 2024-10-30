import 'package:board_client/cubit/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  late final _appCubit = AppCubit.get(context);
  String theme = themeList[0];
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    theme = _appCubit.theme;
    _selected = themeList.indexOf(theme);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((_appCubit.theme == themeList[0])
          ? Icons.sunny
          : (_appCubit.theme == themeList[1])
              ? Icons.dark_mode
              : Icons.cake),
      onPressed: () {
        _selected = (_selected + 1) % themeList.length;
        _appCubit.changeAppMode(themeList[_selected]);
      },
    );
  }
}
