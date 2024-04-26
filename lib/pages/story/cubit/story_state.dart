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

final class PostStoryLoadingState extends StoryState {}

final class PostStorySuccessState extends StoryState {}

final class PostStoryErrorState extends StoryState {}

final class FileRemovedSuccessState extends StoryState {}

final class GetUsersDataByIdLoadingState extends StoryState {}

final class GettUsersDataByIdSuccessState extends StoryState {}

final class NewDurationUpdateState extends StoryState {}
