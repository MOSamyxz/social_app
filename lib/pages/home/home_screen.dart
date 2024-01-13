import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/firebase/firebase_auth.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }

          Users user = BlocProvider.of<AppCubit>(context).getUser;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: AppPadding.screenPadding,
                child: Column(
                  children: [
                    Row(
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
                              BlocProvider.of<AppCubit>(context)
                                  .changeAppMode();
                            },
                            icon: const Icon(Icons.brightness_4_outlined)),
                        GestureDetector(
                          onTap: () {
                            // FirebaseAuthServices().signOut(context);
                            BlocProvider.of<AppCubit>(context).setLangAr();
                          },
                          child: Text(S.of(context).ar),
                        ),
                        GestureDetector(
                          onTap: () {
                            // FirebaseAuthServices().signOut(context);
                            BlocProvider.of<AppCubit>(context).setLangEn();
                          },
                          child: Text(S.of(context).en),
                        )
                      ],
                    ),
                    Card(
                      child: Column(
                        children: [
                          Row(
                            textDirection: TextDirection.ltr,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(AppSize.s10),
                                child: CircleAvatar(
                                  radius: AppSize.r20,
                                  backgroundImage: NetworkImage(user.imageUrl),
                                ),
                              ),
                              const HorizontalSpace(5),
                              Column(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.userName,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    textDirection: TextDirection.ltr,
                                    '7,Sep 2023 14:02 Pm',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
