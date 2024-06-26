import 'package:bloc/bloc.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/data/firebase_auth/firebase_storage_services.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/data/firestore_profile/firestore_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

part 'eidtprofile_state.dart';

class EidtProfileCubit extends Cubit<EidtProfileState> {
  EidtProfileCubit() : super(EidtProfileInitial());

  late TextEditingController userName;
  late TextEditingController bio;
  late TextEditingController birthday;
  late TextEditingController gender;
  List<String> genderList = [S().male, S().female];
  bool isLoading = false;
  bool isLoadingData = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void init({
    required String username,
    required String userbio,
    required String userbirthday,
    required String usergender,
  }) {
    userName = TextEditingController(text: username);
    bio = TextEditingController(text: userbio);
    birthday = TextEditingController(text: userbirthday);
    gender = TextEditingController(text: usergender);
  }

  void onSelectedGender(String value) {
    if (value == 'ذكر') {
      gender.text = 'Male';
    } else if (value == 'أنثى') {
      gender.text = 'Female';
    } else {
      gender.text = value;
    }
  }

  Future<void> updateData() async {
    if (formkey.currentState!.validate()) {
      isLoadingData = true;
      FirestorProfile().updateData(
        userName: userName.text,
        bio: bio.text,
        birthDay: birthday.text,
        gender: gender.text,
      );
      isLoadingData = false;

      Fluttertoast.showToast(
        msg: 'Updated',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Uint8List? cover;
  Uint8List? profile;

  selectCoverImage() async {
    Uint8List pickedImage = await pickProfileCoverImage(ImageSource.gallery);
    emit(ChangeCoverLoadingState());
    cover = pickedImage;
    emit(ChangeCoverSuccessState());
  }

  selectProfileImage() async {
    Uint8List pickedImage = await pickProfileCoverImage(ImageSource.gallery);
    emit(PickImageLoadingState());
    profile = pickedImage;
    emit(PickImageSuccessState());
  }

  FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices();
  Future<void> updateProfile() async {
    isLoading = true;

    emit(ChangeProfileLoadingState());
    String photoUrl = await firebaseStorageServices.uploadImageToStorage(
        'Pics', 'profile', profile!, false);

    FirestorProfile().updateProfile(photoUrl);
    isLoading = false;
    Fluttertoast.showToast(
      msg: 'Updated',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    emit(ChangeProfileSuccessState());
  }

  Future<void> updateCover() async {
    isLoading = true;
    emit(ChangeCoverLoadingState());
    String photoUrl = await firebaseStorageServices.uploadImageToStorage(
        'Pics', 'cover', cover!, false);

    FirestorProfile().updateCover(photoUrl);
    isLoading = false;
    Fluttertoast.showToast(
      msg: 'Updated',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    emit(ChangeCoverSuccessState());
  }
}
