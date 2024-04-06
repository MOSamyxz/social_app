part of '../chat_cubit/chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetChatLoadingState extends ChatState {}

final class GetChatSuccessState extends ChatState {}
