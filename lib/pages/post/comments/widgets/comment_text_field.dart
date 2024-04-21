import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required this.user,
    required this.post,
  });

  final UsersModel user;
  final Post post;

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
                        postId: widget.post.postId, user: widget.user);

                    BlocProvider.of<HomeCubit>(context).commentNotification(
                        post: widget.post, user: widget.user);
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
