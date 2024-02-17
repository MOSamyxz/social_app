import 'package:flutter/material.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16.0 / 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 64, 64, 64).withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  const CircleShimmer({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 64, 64, 64).withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
