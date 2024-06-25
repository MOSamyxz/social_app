import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceivedRequstButton extends StatelessWidget {
  const ReceivedRequstButton({
    super.key,
    required this.snapshotUser,
  });

  final UsersModel snapshotUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NotificationCubit>(context)
            .getUsersById(snapshotUser.receivedRequest);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
        ),
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20.w)),
                child: Text(
                  '${snapshotUser.receivedRequest.length}',
                  style: const TextStyle(color: AppColors.realWhiteColor),
                ),
              ),
              const HorizontalSpace(5),
              const Expanded(child: Text('Received requests')),
              const FaIcon(FontAwesomeIcons.arrowRight)
            ],
          ),
        ),
      ),
    );
  }
}
