import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/shimmer.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Column(
        children: [
          Row(
            children: [
              CircleShimmer(
                size: AppSize.r60,
              ),
              const HorizontalSpace(AppSize.s10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerShimmer(
                    height: AppSize.s20,
                    width: AppSize.s100,
                  ),
                  VerticalSpace(AppSize.s5),
                  ContainerShimmer(
                    height: AppSize.s10,
                    width: AppSize.s50,
                  )
                ],
              )
            ],
          ),
          const VerticalSpace(AppSize.s10),
          ContainerShimmer(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight * 0.3,
          ),
          VerticalSpace(AppSize.s10),
        ],
      ),
    );
  }
}
