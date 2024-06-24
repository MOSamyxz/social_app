import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Row(
        children: [
          CircleShimmer(
            size: AppSize.r25,
          ),
          ContainerShimmer(
            width: AppSize.r10,
            height: AppSize.r44,
          )
        ],
      ),
    );
  }
}
