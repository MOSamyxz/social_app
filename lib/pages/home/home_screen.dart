import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/data/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuthServices().signOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        color: AppColors.darkBlueColor,
        child: const Column(children: [
          Text('1'),
        ]),
      ),
    );
  }
}
