import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFromNow extends StatelessWidget {
  const TimeFromNow({super.key, required this.post, this.isSaved = false});

  final Post post;
  final bool isSaved;
  @override
  Widget build(BuildContext context) {
    return Text(
      getPostTimeText(isSaved ? post.savedAt! : post.createdAt),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

String getPostTimeText(DateTime createdAt) {
  String fromNow = createdAt.fromNow();
  String formatedCreatedAt = DateFormat.yMMMMEEEEd().format(createdAt);
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
        } else if (fromNowSplit[1] == 'days' &&
            int.parse(fromNowSplit[0]) < 7) {
          return '${fromNowSplit[0]}d';
        } else if (fromNow == 'منذ ٣ ايام' &&
            fromNow == 'منذ ٤ ايام' &&
            fromNow == 'منذ ٥ ايام' &&
            fromNow == 'منذ ٦ ايام' &&
            fromNow == 'منذ ۷ ايام') {
          return '${fromNowSplit[1]}ي';
        }
      }
      return formatedCreatedAt;
  }
}
