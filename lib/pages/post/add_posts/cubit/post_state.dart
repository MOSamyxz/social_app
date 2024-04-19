part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class VideoPickedSuccessState extends PostState {}

final class VideoPickedLoadingState extends PostState {}

final class ImagePickedLoadingState extends PostState {}

final class ImagePickedSuccessState extends PostState {}

final class FileRemovedSuccessState extends PostState {}

final class PostLoadingState extends PostState {}

final class PostSuccessState extends PostState {}

final class PostErrorState extends PostState {}
