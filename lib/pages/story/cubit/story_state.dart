part of 'story_cubit.dart';

@immutable
sealed class StoryState {}

final class StoryInitial extends StoryState {}

final class VideoPickedSuccessState extends StoryState {}

final class VideoPickedLoadingState extends StoryState {}

final class ImagePickedLoadingState extends StoryState {}

final class ImagePickedSuccessState extends StoryState {}

final class StroyControllerChangeState extends StoryState {}

final class CurrentIndexChangeState extends StoryState {}

final class GetStoriesState extends StoryState {}

final class StoryLikeDisLikeState extends StoryState {}
