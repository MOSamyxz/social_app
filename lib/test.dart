import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/messege_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/full_screen_chat.dart';
import 'package:chatapp/pages/chat/full_screen_video_chat.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble(
      {super.key,
      required this.messege,
      required this.myUser,
      required this.user});
  final MessageModel messege;
  final UsersModel myUser;
  final UsersModel user;

  @override
<<<<<<<<<<<<<<  ✨ Codeium Command 🌟 >>>>>>>>>>>>>>>>
+  Widget build(BuildContext context) {
+    final isMessageSender = messege.senderId == myUser.uId;
+    final alignment = isMessageSender ? Alignment.centerRight : Alignment.centerLeft;
+    final margin = isMessageSender
+        ? EdgeInsets.only(right: 10.w, left: 60.w, top: 4.h)
+        : EdgeInsets.only(left: 10.w, right: 60.w, top: 4.h);
+    final backgroundColor = isMessageSender
+        ? AppColors.blueColor
+        : BlocProvider.of<AppCubit>(context).isDark
+            ? AppColors.darkGreyColor
+            : AppColors.greyColor;
+    final borderRadius = BorderRadius.only(
+      topLeft: Radius.circular(15.r),
+      topRight: Radius.circular(15.r),
+      bottomLeft: isMessageSender ? Radius.circular(15.r) : Radius.zero,
+      bottomRight: isMessageSender ? Radius.zero : Radius.circular(15.r),
+    );
+
+    return Align(
+      alignment: alignment,
+      child: Container(
+        padding: EdgeInsets.all(8.w),
+        margin: margin,
+        decoration: BoxDecoration(
+          color: backgroundColor,
+          borderRadius: borderRadius,
+        ),
+        child: _buildMessageContent(context),
+      ),
+    );
+  }
+
+  Widget _buildMessageContent(BuildContext context) {
+    if (messege.messageType == 'text') {
+      return _buildTextMessage(context);
+    }
+
+    if (messege.messageType == 'image') {
+      return _buildImageMessage(context);
+    }
+
+    return _buildVideoMessage(context);
+  }
+
+  Widget _buildTextMessage(BuildContext context) {
+    return Row(
+      mainAxisSize: MainAxisSize.min,
+      children: [
+        Flexible(
+          child: Text(
+            messege.messageContent!,
+            softWrap: true,
+            style: TextStyle(fontSize: 16.sp),
+          ),
+        ),
+        const HorizontalSpace(5),
+        Column(
+          children: [
+            SizedBox(
+              height: 16.h,
+            ),
+            Text(
+              formatDateTime(
+                '${messege.messageCreatedAt}',
+              ),
+              style: TextStyle(fontSize: 11.sp),
+            ),
+          ],
+        ),
+      ],
+    );
+  }
+
+  Widget _buildImageMessage(BuildContext context) {
+    return GestureDetector(
+      onTap: () {
+        Navigator.push(
+            context,
+            MaterialPageRoute(
+                builder: (context) => FullImageScreenChat(
+                      messege: messege,
+                      user: user,
+                      myUser: myUser,
+                    )));
+      },
+      child: ClipRRect(
+        borderRadius: borderRadius,
+        child: Column(
+          mainAxisSize: MainAxisSize.min,
+          crossAxisAlignment: CrossAxisAlignment.end,
+          children: [
+            CachedNetworkImage(
+              imageUrl: messege.messageFileUrl!,
+              width: ScreenUtil().screenWidth * 0.5,
+            ),
+            messege.messageContent == ''
+                ? SizedBox()
+                : SizedBox(
+                    width: ScreenUtil().screenWidth * 0.5,
+                    child: Text(
+                      messege.messageContent!,
+                      style: TextStyle(fontSize: 16.sp),
+                    ),
+                  )
+          ],
+        ),
+      ),
+    );
+  }
+
+  Widget _buildVideoMessage(BuildContext context) {
+    return ClipRRect(
+      borderRadius: borderRadius,
+      child: Column(
+        crossAxisAlignment: CrossAxisAlignment.end,
+        children: [
+          SizedBox(
+            width: ScreenUtil().screenWidth * 0.5,
+            child: VideoViewHome(
+              video: Uri.parse(messege.messageFileUrl!),
+              isSearchView: true,
+              child: FullScreenVideoChat(
+                message: messege,
+                user: user,
+                myUser: myUser,
+              ),
+            ),
+          ),
+          messege.messageContent == ''
+              ? SizedBox()
+              : Text(
+                  messege.messageContent!,
+                  style: TextStyle(fontSize: 16.sp),
+                )
+        ],
+      ),
+    );
+  }
-  Widget build(BuildContext context) {
-    return Align(
-      alignment: messege.senderId == myUser.uId
-          ? Alignment.centerRight
-          : Alignment.centerLeft,
-      child: Container(
-        padding: EdgeInsets.all(8.w),
-        margin: messege.senderId == myUser.uId
-            ? EdgeInsets.only(right: 10.w, left: 60.w, top: 4.h)
-            : EdgeInsets.only(left: 10.w, right: 60.w, top: 4.h),
-        decoration: BoxDecoration(
-          color: messege.senderId == myUser.uId
-              ? AppColors.blueColor
-              : BlocProvider.of<AppCubit>(context).isDark
-                  ? AppColors.darkGreyColor
-                  : AppColors.greyColor,
-          borderRadius: BorderRadius.only(
-            topLeft: Radius.circular(15.r),
-            topRight: Radius.circular(15.r),
-            bottomLeft: messege.senderId == myUser.uId
-                ? Radius.circular(15.r)
-                : Radius.zero,
-            bottomRight: messege.senderId == myUser.uId
-                ? Radius.zero
-                : Radius.circular(15.r),
-          ),
-        ),
-        child: messege.messageType == 'text'
-            ? Row(
-                mainAxisSize: MainAxisSize.min,
-                children: [
-                  Flexible(
-                    child: Text(
-                      messege.messageContent!,
-                      softWrap: true,
-                      style: TextStyle(fontSize: 16.sp),
-                    ),
-                  ),
-                  const HorizontalSpace(5),
-                  Column(
-                    children: [
-                      SizedBox(
-                        height: 16.h,
-                      ),
-                      Text(
-                        formatDateTime(
-                          '${messege.messageCreatedAt}',
-                        ),
-                        style: TextStyle(fontSize: 11.sp),
-                      ),
-                    ],
-                  ),
-                ],
-              )
-            : messege.messageType == 'image'
-                ? GestureDetector(
-                    onTap: () {
-                      Navigator.push(
-                          context,
-                          MaterialPageRoute(
-                              builder: (context) => FullImageScreenChat(
-                                    messege: messege,
-                                    user: user,
-                                    myUser: myUser,
-                                  )));
-                    },
-                    child: ClipRRect(
-                      borderRadius: BorderRadius.only(
-                        topLeft: Radius.circular(15.r),
-                        topRight: Radius.circular(15.r),
-                        bottomLeft: messege.senderId == myUser.uId
-                            ? Radius.circular(15.r)
-                            : Radius.zero,
-                        bottomRight: messege.senderId == myUser.uId
-                            ? Radius.zero
-                            : Radius.circular(15.r),
-                      ),
-                      child: Column(
-                        mainAxisSize: MainAxisSize.min,
-                        crossAxisAlignment: CrossAxisAlignment.end,
-                        children: [
-                          CachedNetworkImage(
-                            imageUrl: messege.messageFileUrl!,
-                            width: ScreenUtil().screenWidth * 0.5,
-                          ),
-                          messege.messageContent == ''
-                              ? SizedBox()
-                              : SizedBox(
-                                  width: ScreenUtil().screenWidth * 0.5,
-                                  child: Text(
-                                    messege.messageContent!,
-                                    style: TextStyle(fontSize: 16.sp),
-                                  ),
-                                )
-                        ],
-                      ),
-                    ),
-                  )
-                : ClipRRect(
-                    borderRadius: BorderRadius.only(
-                      topLeft: Radius.circular(15.r),
-                      topRight: Radius.circular(15.r),
-                      bottomLeft: messege.senderId == myUser.uId
-                          ? Radius.circular(15.r)
-                          : Radius.zero,
-                      bottomRight: messege.senderId == myUser.uId
-                          ? Radius.zero
-                          : Radius.circular(15.r),
-                    ),
-                    child: Column(
-                      crossAxisAlignment: CrossAxisAlignment.end,
-                      children: [
-                        SizedBox(
-                          width: ScreenUtil().screenWidth * 0.5,
-                          child: VideoViewHome(
-                            video: Uri.parse(messege.messageFileUrl!),
-                            isSearchView: true,
-                            child: FullScreenVideoChat(
-                              message: messege,
-                              user: user,
-                              myUser: myUser,
-                            ),
-                          ),
-                        ),
-                        messege.messageContent == ''
-                            ? SizedBox()
-                            : Text(
-                                messege.messageContent!,
-                                style: TextStyle(fontSize: 16.sp),
-                              )
-                      ],
-                    ),
-                  ),
-      ),
-    );
-  }
<<<<<<<  b3f913b3-f732-4cf4-8a9f-413fd563fe16  >>>>>>>
}

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}
