import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/comment_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({
    super.key,
    required this.postId,
  });
  final String postId;

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => HomeCubit()..init(),
      child: Scaffold(
        backgroundColor: BlocProvider.of<AppCubit>(context).isDark
            ? AppColors.darkScaffoldColor
            : AppColors.realWhiteColor,
        appBar: AppBar(
          backgroundColor: BlocProvider.of<AppCubit>(context).isDark
              ? AppColors.darkScaffoldColor
              : AppColors.realWhiteColor,
          title: const Text('Comments'),
        ),
        body: Container(
          height: ScreenUtil().screenHeight,
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(postId)
                    .collection('comments')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<CommentModel> comments =
                        snapshot.data!.docs.map((doc) {
                      return CommentModel.fromMap(doc.data());
                    }).toList();
                    return Expanded(
                      child: ListView.separated(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final isLiked = comments[index]
                              .likes!
                              .contains(FirebaseAuth.instance.currentUser!.uid);

                          return Padding(
                            padding: AppPadding.screenPadding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      comments[index].authorProfileUrl),
                                ),
                                const HorizontalSpace(10),
                                Column(
                                  textDirection: isArabicText(
                                          '${comments[index].createdAt!}')
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.h),
                                      decoration: BoxDecoration(
                                          color:
                                              BlocProvider.of<AppCubit>(context)
                                                      .isDark
                                                  ? Theme.of(context)
                                                      .cardTheme
                                                      .color
                                                  : AppColors
                                                      .lightScaffoldColor,
                                          borderRadius: BorderRadius.circular(
                                              AppSize.r15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comments[index].authorName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            comments[index].text,
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BlocBuilder<HomeCubit, HomeState>(
                                      builder: (context, state) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              getPostTimeText(
                                                  comments[index].createdAt!),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const HorizontalSpace(10),
                                            GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<HomeCubit>(
                                                        context)
                                                    .likeDislikeComment(
                                                        postId: postId,
                                                        commentId:
                                                            comments[index]
                                                                .commentId,
                                                        likes: comments[index]
                                                            .likes!,
                                                        user: user);
                                              },
                                              child: Text(
                                                S.of(context).like,
                                                style: isLiked
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color: AppColors
                                                                .blueColor)
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const VerticalSpace(5);
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return CommentTextField(user: user, postId: postId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

String getPostTimeText(DateTime createdAt) {
  String fromNow = createdAt.fromNow();
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

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required this.user,
    required this.postId,
  });

  final UsersModel user;
  final String postId;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  late FocusNode _focusNode;
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isTextFieldFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isTextFieldFocused) {
          _focusNode.unfocus();

          return false; // Prevent back navigation if the TextField is focused
        }
        return true; // Allow back navigation if the TextField is not focused
      },
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              focusNode: _focusNode,
              onTap: () {
                setState(() {
                  _isTextFieldFocused = true;
                });
              },
              controller: BlocProvider.of<HomeCubit>(context).commentController,
              decoration: InputDecoration(
                  hintText: 'Comment as ${widget.user.userName}',
                  hintStyle: TextStyle(
                      color: AppColors.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).cardTheme.color!),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).cardTheme.color!),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).cardTheme.color!),
                      borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: Theme.of(context).cardTheme.color),
            )),
            if (_isTextFieldFocused)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<HomeCubit>(context).createComment(
                        postId: widget.postId, user: widget.user);
                    BlocProvider.of<HomeCubit>(context)
                        .commentController
                        .clear();
                  },
                  child: const FaIcon(FontAwesomeIcons.paperPlane),
                ),
              )
          ],
        ),
      ),
    );
  }
}





/*
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/comment_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/post/cubit/post_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen(
      {super.key,
      required this.postId,
      required this.commentdata,
      required this.commentLeanght});
  final String postId;
  final List<CommentModel> commentdata;
  final int commentLeanght;
  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => PostCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkScaffoldColor,
          title: const Text('Comments'),
        ),
        body: Container(
          height: ScreenUtil().screenHeight,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: commentLeanght,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: AppPadding.screenPadding,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                commentdata[index].authorProfileUrl),
                          ),
                          const HorizontalSpace(10),
                          Container(
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                                color: AppColors.darkCardColor,
                                borderRadius:
                                    BorderRadius.circular(AppSize.r15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  commentdata[index].authorName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Text(
                                  commentdata[index].text,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const VerticalSpace(5);
                  },
                ),
              ),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.imageUrl),
                          radius: AppSize.r20,
                        ),
                        Expanded(
                            child: TextField(
                          controller: BlocProvider.of<PostCubit>(context)
                              .commentController,
                          decoration: InputDecoration(
                              hintText: 'Comment as ${user.userName}',
                              border: InputBorder.none),
                        )),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<PostCubit>(context)
                                .createComment(postId: postId, user: user);
                            BlocProvider.of<PostCubit>(context)
                                .commentController
                                .clear();
                          },
                          child: const FaIcon(FontAwesomeIcons.paperPlane),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

 */