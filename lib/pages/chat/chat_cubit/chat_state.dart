part of '../chat_cubit/chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetChatLoadingState extends ChatState {}

final class GetChatSuccessState extends ChatState {}

final class SendMessageLoadingState extends ChatState {}

final class SendMessageSuccessState extends ChatState {}

final class SendMessageErrorState extends ChatState {}

final class VideoPickedLoadingState extends ChatState {}

final class VideoPickedSuccessState extends ChatState {}

final class ImagePickedLoadingState extends ChatState {}

final class ImagePickedSuccessState extends ChatState {}

final class FileRemovedSuccessState extends ChatState {}
