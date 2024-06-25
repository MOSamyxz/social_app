import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getTimeText(DateTime timestamp, BuildContext context, bool isYear) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);
  final differenceInMin = difference.inMinutes;
  final differenceInHour = difference.inHours;
  final differenceInDays = difference.inDays;
//? Duration in minutes
  final String durationInMinAr = differenceInMin.toArabicNumbers;
  final String durationInMinEn = differenceInMin.toString();
  final String durationInMinArEn =
      CacheHelper.sharedPreferences.getString('lang') == 'ar'
          ? durationInMinAr
          : durationInMinEn;
  //? Duration in hours
  final String durationInHourAr = differenceInHour.toArabicNumbers;
  final String durationInHourEn = differenceInHour.toString();
  final String durationInHourArEn =
      CacheHelper.sharedPreferences.getString('lang') == 'ar'
          ? durationInHourAr
          : durationInHourEn;
  //? Duration in days
  final String durationInDaysAr = differenceInDays.toArabicNumbers;
  final String durationInDaysEn = differenceInDays.toString();
  final String durationInDaysArEn =
      CacheHelper.sharedPreferences.getString('lang') == 'ar'
          ? durationInDaysAr
          : durationInDaysEn;

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '$durationInMinArEn${S.of(context).min}';
  } else if (difference.inHours < 24) {
    return '$durationInHourArEn${S.of(context).hour}';
  } else if (difference.inDays < 30) {
    return '$durationInDaysArEn${S.of(context).day}';
  } else if (differenceInDays ~/ 30 < 12) {
    var durationInMonths = differenceInDays ~/ 30;
    return '$durationInMonths${S.of(context).month}';
  } else if (isYear == true && differenceInDays ~/ 30 > 12) {
    var durationInyears = differenceInDays ~/ 365;
    return '$durationInyears${S.of(context).year}';
  } else {
    return DateFormat.yMMMMEEEEd().format(timestamp);
  }
}
