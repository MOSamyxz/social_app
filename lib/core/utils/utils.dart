import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

pickProfileCoverImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

// pick image method
Future<File?> pickImage() async {
  File? image;
  final picker = ImagePicker();
  final file = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 720,
    maxWidth: 720,
  );

  if (file != null) {
    image = File(file.path);
  }

  return image;
}

Future<File?> pickVideo() async {
  File? video;
  final picker = ImagePicker();
  final file = await picker.pickVideo(
    source: ImageSource.gallery,
    maxDuration: const Duration(minutes: 5),
  );

  if (file != null) {
    video = File(file.path);
  }

  return video;
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

bool isValidUsername(String username) {
  final RegExp regex = RegExp(r'^[a-zA-Z0-9أ-ي_ ]+$');
  return regex.hasMatch(username);
}

extension FromNow on DateTime {
  String fromNow() => Jiffy.parseFromDateTime(this).fromNow();
}

extension FromDate on DateTime {
  String fromDate() => Jiffy.parseFromDateTime(this)
      .from(Jiffy.parseFromDateTime(DateTime(2035, 12, 29, 1, 30)));
}

bool isArabicText(String text) {
  return Bidi.hasAnyRtl(text);
}
