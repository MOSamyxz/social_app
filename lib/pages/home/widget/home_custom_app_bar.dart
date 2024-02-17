import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/firebase/firebase_auth.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCustomAppBar extends StatelessWidget {
  const HomeCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Row(
        children: [
          Text(
            S.of(context).hwar,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                FirebaseAuthServices().signOut(context);
                //     BlocProvider.of<AppCubit>(context)
                //      .changeAppMode();
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                // FirebaseAuthServices().signOut(context);
                BlocProvider.of<AppCubit>(context).changeAppMode();
              },
              icon: const Icon(Icons.brightness_4_outlined)),
          GestureDetector(
            onTap: () {
              // FirebaseAuthServices().signOut(context);
              BlocProvider.of<AppCubit>(context).setLangAr();
            },
            child: Text(S.of(context).ar),
          ),
          const HorizontalSpace(10),
          GestureDetector(
            onTap: () {
              // FirebaseAuthServices().signOut(context);
              BlocProvider.of<AppCubit>(context).setLangEn();
            },
            child: Text(S.of(context).en),
          )
        ],
      ),
    );
  }
}
