import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/Chat/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatsScreen()));
              },
              icon: const FaIcon(FontAwesomeIcons.facebookMessenger)),
        ],
      ),
    );
  }
}
