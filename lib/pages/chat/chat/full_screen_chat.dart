import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullImageScreenChat extends StatefulWidget {
  final MessageModel messege;
  final UsersModel user;
  final UsersModel myUser;
  const FullImageScreenChat({
    super.key,
    required this.messege,
    required this.user,
    required this.myUser,
  });

  @override
  _FullImageScreenChatState createState() => _FullImageScreenChatState();
}

class _FullImageScreenChatState extends State<FullImageScreenChat> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        foregroundColor: AppColors.realWhiteColor,
        backgroundColor: AppColors.blackColor,
        title: Text(
          widget.messege.senderId == widget.myUser.uId
              ? 'from: ${widget.myUser.userName}'
              : 'from: ${widget.user.userName}',
        ),
      ),
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previousScale = _scale;
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          _scale = _previousScale * details.scale;
          setState(() {});
        },
        onDoubleTap: () {
          setState(() {
            _scale = _scale == 1.0 ? 2.0 : 1.0;
          });
        },
        child: BlocProvider(
          create: (context) => HomeCubit(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Center(
                child: Transform.scale(
                  scale: _scale,
                  child: Image.network(widget.messege.messageFileUrl!),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
