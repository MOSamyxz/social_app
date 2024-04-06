part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatInitial extends ChatsState {}

final class GetAllChatsLoadingState extends ChatsState {}

final class GetAllChatsSuccessState extends ChatsState {}
