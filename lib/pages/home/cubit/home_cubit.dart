import 'package:bloc/bloc.dart';
import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/widgets/reaction_button.dart';
import 'package:chatapp/data/firebase_auth/firestore_services.dart';
import 'package:chatapp/data/firestore_posts/firestore_notifications.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/data/firestore_posts/firestore_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  late TextEditingController commentController;
  late TextEditingController storyController;

  void init() async {
    commentController = TextEditingController();
    storyController = TextEditingController();
  }

  UsersModel? _userById;
  final FirestoreServices _firestoreServices = FirestoreServices();
  Future<void> getUserById(userid) async {
    emit(GetUserDataByIdLoadingState());

    UsersModel user = await _firestoreServices.getUserDetails(
        collection: 'users', doc: userid);
    _userById = user;

    emit(GettUserDataByIdSuccessState());
  }

  UsersModel get userById => _userById!;

  List<UsersModel>? _usersById;
  Future<void> getUsersById(userid) async {
    emit(GetUsersDataByIdLoadingState());

    List<UsersModel> users = await _firestoreServices.getUsersDetailsByIds(
        collection: 'users', userIds: userid);
    _usersById = users;
    emit(GetUsersDataByIdSuccessState());
  }

  List<UsersModel> get usersById => _usersById!;

  void createComment({
    required String postId,
    required UsersModel user,
  }) {
    FireStorePosts().postComment(
      postId: postId,
      text: commentController.text,
      user: user,
    );
  }

  Future<void> likeDislikePost(
      {required String postId,
      required List<String> likesData,
      required List<String> likes,
      required UsersModel user}) async {
    await FireStorePosts().likeDislikePost(
        postId: postId,
        likes: likes,
        user: user,
        likesData: likesData,
        likeType: react);
  }

  Future<void> likeNotification(
      {required Post post,
      String? lastReactID,
      String? lastReactImageUrl,
      String? lastReactName,
      required UsersModel user}) async {
    await FireStoreNotifications().sendReactNotification(
      likeType: react,
      post: post,
      user: user,
    );
  }

  Future<void> removeLikeNotification(
      {required Post post, required UsersModel user}) async {
    await FireStoreNotifications().sendRemoveReactNotification(
      likeType: react,
      post: post,
      user: user,
    );
    if (post.likes.length == 1) {
      removeNotification(post: post);
    }
  }

  Future<void> removeNotification({required Post post}) async {
    await FireStoreNotifications().removeNotification(
      post: post,
    );
  }

  Future<void> updateLike(
      {required String postId,
      required List<String> likes,
      required UsersModel user}) async {
    await FireStorePosts()
        .updateLike(postId: postId, likeType: react, likes: likes, user: user);
  }

  ReactionType selectedReaction = ReactionType.Like;
  bool showReactionButtons = false;
  String react = 'Like';

  void reactButtonVisibility() {
    showReactionButtons = !showReactionButtons;
    emit(ReactButtonVisibilityState());
  }

  void handleReactionSelected({
    required ReactionType reactionType,
    required Post post,
    required UsersModel user,
  }) {
    selectedReaction = reactionType;
    bool isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
    // Perform any other actions based on the selected reaction
    switch (reactionType) {
      case ReactionType.Like:
        // Handle like reaction
        react = 'Like';
        showReactionButtons = !showReactionButtons;
        isLiked
            ? updateLike(postId: post.postId, likes: post.likes, user: user)
            : likeDislikePost(
                postId: post.postId,
                likes: post.likes,
                user: user,
                likesData: post.likesData,
              );

        // Handle like reaction
        break;
      case ReactionType.Wow:
        // Handle Wow reaction
        react = 'Wow';
        showReactionButtons = !showReactionButtons;
        isLiked
            ? updateLike(postId: post.postId, likes: post.likes, user: user)
            : likeDislikePost(
                postId: post.postId,
                likes: post.likes,
                user: user,
                likesData: post.likesData,
              );
        break;
      case ReactionType.Love:
        // Handle love reaction
        react = 'Love';

        showReactionButtons = !showReactionButtons;
        isLiked
            ? updateLike(postId: post.postId, likes: post.likes, user: user)
            : likeDislikePost(
                postId: post.postId,
                likes: post.likes,
                user: user,
                likesData: post.likesData,
              );

        break;
      case ReactionType.Haha:
        // Handle haha reaction
        react = 'HaHa';

        showReactionButtons = !showReactionButtons;
        isLiked
            ? updateLike(postId: post.postId, likes: post.likes, user: user)
            : likeDislikePost(
                postId: post.postId,
                likes: post.likes,
                user: user,
                likesData: post.likesData,
              );

        break;
      case ReactionType.Angry:
        // Handle angry reaction
        react = 'Angry';

        showReactionButtons = !showReactionButtons;
        isLiked
            ? updateLike(postId: post.postId, likes: post.likes, user: user)
            : likeDislikePost(
                postId: post.postId,
                likes: post.likes,
                user: user,
                likesData: post.likesData,
              );

        break;
      case ReactionType.Sad:
        // Handle sad reaction
        react = 'Sad';

        showReactionButtons = !showReactionButtons;
        isLiked
            ? updateLike(postId: post.postId, likes: post.likes, user: user)
            : likeDislikePost(
                postId: post.postId,
                likes: post.likes,
                user: user,
                likesData: post.likesData,
              );

        break;
    }
  }

  Color? getLikeColor({required bool isLiked, required String likeType}) {
    if (isLiked) {
      Map<String, Color> likeTypeToColor = {
        'Like': AppColors.blueColor,
        'Love': Colors.pinkAccent,
        'HaHa': Colors.amber,
        'Angry': Colors.red,
        'Sad': Colors.amber,
        'Wow': Colors.amber,
      };
      return likeTypeToColor[likeType];
    }
    return null;
  }

  String? getLikeReact({required bool isLiked, required String likeType}) {
    if (isLiked) {
      Map<String, String> likeTypeToColor = {
        'Like': AppAssets.like,
        'Love': AppAssets.love,
        'HaHa': AppAssets.haha,
        'Angry': AppAssets.angry,
        'Sad': AppAssets.sad,
        'Wow': AppAssets.wow,
      };
      return likeTypeToColor[likeType];
    }
    return null;
  }

  String getReact(BuildContext context,
      {required bool isLiked, required String likeType}) {
    if (isLiked) {
      Map<String, String> likeTypeToColor = {
        'Like': S.of(context).like,
        'Love': S.of(context).love,
        'HaHa': S.of(context).haha,
        'Angry': S.of(context).angry,
        'Sad': S.of(context).sad,
        'Wow': S.of(context).wow,
      };
      return likeTypeToColor[likeType] ?? S.of(context).like;
    }
    return '';
  }

  Future<void> deletePost({required String postId}) async {
    await FireStorePosts().deletePost(postId);
  }

  Future<void> likeDislikeComment(
      {required String postId,
      required String commentId,
      required List<String> likes,
      required UsersModel user}) async {
    await FireStorePosts().likeDislikeComment(
      postId: postId,
      likes: likes,
      user: user,
      commentId: commentId,
    );
  }

  void showBottomSheet(BuildContext context, Widget childe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height, child: childe);
      },
    );
  }

  void savePost(context,
      {required String posterId,
      required String posterName,
      required String posterProfileUrl,
      required String content,
      required String postId,
      required String postType,
      String? downloadUrl,
      required DateTime createdAt}) async {
    FireStorePosts()
        .savePost(
            posterName: posterName,
            posterId: posterId,
            posterProfileUrl: posterProfileUrl,
            content: content,
            postType: postType,
            downloadUrl: downloadUrl,
            postId: postId)
        .then((value) {
      Fluttertoast.showToast(
        msg: 'Saved',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }).catchError((_) {});
  }
}
