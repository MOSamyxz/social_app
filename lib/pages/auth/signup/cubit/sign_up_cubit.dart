import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/data/firebase/firebase_auth.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<String> genderList = [S().male, S().female];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController gender = TextEditingController(text: S().male);
  Uint8List? image;
  bool isLoading = false;
  void onSelectedGender(String value) {
    if (value == 'ذكر') {
      gender.text = 'Male';
    } else if (value == 'أنثى') {
      gender.text = 'Female';
    } else {
      gender.text = value;
    }
  }

  selectImage() async {
    Uint8List pickedImage = await pickImage(ImageSource.gallery);
    emit(ChangeAvatarLoadingState());

    image = pickedImage;
    emit(ChangeAvatarSuccessState());
  }

  void signUp(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      emit(SignUpLoadingState());
      isLoading = true;
      try {
        await FirebaseAuthServices().signUp(
            email: email.text,
            password: password.text,
            context: context,
            username: '${fName.text} ${lName.text}',
            gender: gender.text,
            file: image!);
        controlerDispose();

        isLoading = false;
        emit(SignUpSuccessState());
      } on Exception catch (e) {
        emit(SignUpErrorState());
        print(e.toString());
      }
    }
  }

  void controlerDispose() {
    email.clear();
    password.clear();
    fName.clear();
    lName.clear();
  }
}
