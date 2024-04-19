import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageVideoPickerButton extends StatelessWidget {
  const ImageVideoPickerButton({
    required this.onTap,
    required this.icon,
    super.key,
  });
  final void Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
            backgroundColor: Theme.of(context).cardTheme.color,
            child: FaIcon(icon)),
      ),
    );
  }
}
