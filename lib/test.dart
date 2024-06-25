import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';

String getPostTimeText(DateTime savedAt) {
  String fromNow = savedAt.fromNow();
  List<String> fromNowSplit = fromNow.split(' ');

  switch (fromNow) {
    case 'a few seconds ago':
      return 'Just now';
    case 'منذ ثانية واحدة':
      return 'الآن';
    case 'a minute ago':
      return '1m';
    case 'منذ دقيقة واحدة':
      return '${1.toArabicNumbers}د';
    case '2 minutes ago':
      return '2m';
    case 'منذ دقيقتين':
      return '${2.toArabicNumbers}د';
    case 'an hour ago':
      return '1h';
    case 'منذ ساعة واحدة':
      return '${1.toArabicNumbers}س';
    case 'منذ ساعتين':
      return '${2.toArabicNumbers}س';
    case 'a day ago':
      return '1d';
    case 'منذ يوم واحد':
      return '${1.toArabicNumbers}ي';
    case 'منذ يومين':
      return '${2.toArabicNumbers}ي';
    case 'a month ago':
      return '1M';
    case 'منذ شهر واحد':
      return '${1.toArabicNumbers}ش';
    case 'منذ شهرين':
      return '${2.toArabicNumbers}ش';

    case 'a year ago':
      return '1y';
    case 'منذ عام واحد':
      return '${1.toArabicNumbers}ع';
    default:
      if (fromNowSplit.length > 1) {
        if (fromNowSplit[1] == 'minutes') {
          return '${fromNowSplit[0]}m';
        } else if (fromNowSplit[2] == 'دقيقة' || fromNowSplit[2] == 'دقائق') {
          return '${fromNowSplit[1]}د';
        } else if (fromNowSplit[1] == 'hours') {
          return '${fromNowSplit[0]}h';
        } else if (fromNowSplit[2] == 'ساعة' || fromNowSplit[2] == 'ساعات') {
          return '${fromNowSplit[1]}س';
        } else if (fromNowSplit[1] == 'days') {
          return '${fromNowSplit[0]}d';
        } else if (fromNowSplit[2] == 'يوم' || fromNowSplit[2] == 'ايام') {
          return '${fromNowSplit[1]}ي';
        } else if (fromNowSplit[1] == 'months') {
          return '${fromNowSplit[0]}M';
        } else if (fromNowSplit[2] == 'شهر' || fromNowSplit[2] == 'اشهر') {
          return '${fromNowSplit[1]}ش';
        } else if (fromNowSplit[1] == 'years') {
          return '${fromNowSplit[0]}y';
        } else if (fromNowSplit[2] == 'عامًا' || fromNowSplit[2] == 'اعوام') {
          return '${fromNowSplit[1]}ع';
        }
      }
      return fromNow;
  }
}
