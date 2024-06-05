library values;

import 'dart:io';

import 'package:board_client/generated/image.pb.dart';
import 'package:board_client/widgets/buttons/container_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../generated/ad.pb.dart';

part 'colors.dart';

part 'strings.dart';

part 'style.dart';

part 'auth_value.dart';

part 'markup.dart';

part 'nav_item.dart';

class Const {
  //main const
  static const int PhoneWidth = 700;
  static const double HeaderHight = 65;
  static const String HOST = "77.246.159.112";
  static const int PORT = 9090;

  static List<ImageProto> imageFromFilePicker(List<XFile> files) {
    return List.generate(files.length,
            (i) => ImageProto(image: File(files[i].path).readAsBytesSync()))
        .toList();
  }
}
