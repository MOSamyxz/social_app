import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/custom_text_icon_button.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/post/add_posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageVideoAddPostButton extends StatelessWidget {
  const ImageVideoAddPostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s10),
      child: Row(
        children: [
          Expanded(
            child: CustomTextIconButton(
              icon: FontAwesomeIcons.image,
              data: S.of(context).image,
              onPressed: () async {
                BlocProvider.of<PostCubit>(context).pickedImage();
              },
            ),
          ),
          const HorizontalSpace(10),
          Expanded(
            child: CustomTextIconButton(
              icon: FontAwesomeIcons.film,
              data: S.of(context).video,
              onPressed: () async {
                BlocProvider.of<PostCubit>(context).pickedVideo();
              },
            ),
          ),
        ],
      ),
    );
  }
}
