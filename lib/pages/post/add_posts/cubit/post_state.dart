part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class VideoPickedSuccessState extends PostState {}

final class VideoPickedLoadingState extends PostState {}

final class ImagePickedSuccessState extends PostState {}

final class FileRemovedSuccessState extends PostState {}
