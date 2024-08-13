 library values;

import 'dart:io';

import 'package:board_client/generated/image.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/ad_list_bloc/ad_list_bloc.dart';
import '../generated/ad.pb.dart';

part 'colors.dart';

part 'strings.dart';

part 'auth_value.dart';

part 'markup.dart';

part 'nav_item.dart';

class Const {
  //main const
  static const int PhoneWidth = 700;
  static const double HeaderHight = 70;
  static const int cellWidthInt = 190;
  static const double cellWidth = 190;
  static const String HOST = "77.246.159.112";
  static const int PORT = 9090;

}

class Address {
  static const List<String> lc = ["Кампус", 'Город', "Другое"];
  static const List<String> campus = [
    "9",
    "10",
    "11",
    "8.2",
    "8.1",
    "2.1",
    "1.8",
    "7.1",
    "7.2",
  ];
  static const List<String> gorod = [
    'Пограничная 26',
    "Державина 21",
    "Державина 15"
  ];
}

class Item {
  final int i;
  final String name;

  Item(this.i, this.name);
}
