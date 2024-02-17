import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullImageScreen extends StatefulWidget {
  final String imageUrl;

  const FullImageScreen({
    super.key,
    required this.imageUrl,
  });

  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previousScale = _scale;
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          _scale = _previousScale * details.scale;
          setState(() {});
        },
        onDoubleTap: () {
          setState(() {
            _scale = _scale == 1.0 ? 2.0 : 1.0;
          });
        },
        child: BlocProvider(
          create: (context) => HomeCubit(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Center(
                child: Transform.scale(
                  scale: _scale,
                  child: Image.network(widget.imageUrl),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
