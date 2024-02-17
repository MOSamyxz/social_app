import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:flutter/material.dart';

class AppPostHeader extends StatelessWidget {
  const AppPostHeader({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSize.s5),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl),
            radius: AppSize.r20,
          ),
        ),
        const HorizontalSpace(10),
        Text(
          user.userName,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
