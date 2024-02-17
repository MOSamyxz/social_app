// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `7war`
  String get hwar {
    return Intl.message(
      '7war',
      name: 'hwar',
      desc: '',
      args: [],
    );
  }

  /// `AR`
  String get ar {
    return Intl.message(
      'AR',
      name: 'ar',
      desc: '',
      args: [],
    );
  }

  /// `EN`
  String get en {
    return Intl.message(
      'EN',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get hello {
    return Intl.message(
      'Welcome back!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Sign in and make new friends`
  String get signInAndmakeNewFriends {
    return Intl.message(
      'Sign in and make new friends',
      name: 'signInAndmakeNewFriends',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Get started free`
  String get getStartedFree {
    return Intl.message(
      'Get started free',
      name: 'getStartedFree',
      desc: '',
      args: [],
    );
  }

  /// `Create an account and start making new friends`
  String get createAnAccountAndStartMakingNewFriends {
    return Intl.message(
      'Create an account and start making new friends',
      name: 'createAnAccountAndStartMakingNewFriends',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid username!`
  String get pleaseEnterValidUserName {
    return Intl.message(
      'Please enter a valid username!',
      name: 'pleaseEnterValidUserName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username!`
  String get pleaseEnterUserName {
    return Intl.message(
      'Please enter your username!',
      name: 'pleaseEnterUserName',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid Email!`
  String get pleaseEnterAValidEmail {
    return Intl.message(
      'Please enter a valid Email!',
      name: 'pleaseEnterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email!`
  String get emailMustNotBeEmpty {
    return Intl.message(
      'Please enter your email!',
      name: 'emailMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPassword {
    return Intl.message(
      'Forget password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a Password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter a Password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `This field can't be empty`
  String get genderCantBeEmpty {
    return Intl.message(
      'This field can\'t be empty',
      name: 'genderCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password can't be less than 6`
  String get shortPassword {
    return Intl.message(
      'Password can\'t be less than 6',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password can't be more than 16`
  String get longPassword {
    return Intl.message(
      'Password can\'t be more than 16',
      name: 'longPassword',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a Password again`
  String get pleaseEnterPasswordAgain {
    return Intl.message(
      'Please enter a Password again',
      name: 'pleaseEnterPasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `By signing up you agree to our`
  String get bySigningUpYouAgreeToOur {
    return Intl.message(
      'By signing up you agree to our',
      name: 'bySigningUpYouAgreeToOur',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get SignUp {
    return Intl.message(
      'Sign up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// ` Go back to sign in`
  String get goBackToSignIn {
    return Intl.message(
      ' Go back to sign in',
      name: 'goBackToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email associated with your account abd we'll send an email with verify code to reset your password.`
  String get enterTheEmail {
    return Intl.message(
      'Enter the email associated with your account abd we\'ll send an email with verify code to reset your password.',
      name: 'enterTheEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send verify code`
  String get sendVerifyCode {
    return Intl.message(
      'Send verify code',
      name: 'sendVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email`
  String get emailAlreadyInUse {
    return Intl.message(
      'The account already exists for that email',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Please check the verification link send to your email`
  String get checkEmail {
    return Intl.message(
      'Please check the verification link send to your email',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please check the link send to your email`
  String get checkEmailResetPassword {
    return Intl.message(
      'Please check the link send to your email',
      name: 'checkEmailResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email first`
  String get verifyEmail {
    return Intl.message(
      'Please verify your email first',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email`
  String get noUserForThisEmail {
    return Intl.message(
      'No user found for that email',
      name: 'noUserForThisEmail',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user`
  String get wrongPassword {
    return Intl.message(
      'Wrong password provided for that user',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Create post`
  String get createPost {
    return Intl.message(
      'Create post',
      name: 'createPost',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `What's on your mind?`
  String get whatOnMind {
    return Intl.message(
      'What\'s on your mind?',
      name: 'whatOnMind',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Love`
  String get love {
    return Intl.message(
      'Love',
      name: 'love',
      desc: '',
      args: [],
    );
  }

  /// `Sad`
  String get sad {
    return Intl.message(
      'Sad',
      name: 'sad',
      desc: '',
      args: [],
    );
  }

  /// `Angry`
  String get angry {
    return Intl.message(
      'Angry',
      name: 'angry',
      desc: '',
      args: [],
    );
  }

  /// `Haha`
  String get haha {
    return Intl.message(
      'Haha',
      name: 'haha',
      desc: '',
      args: [],
    );
  }

  /// `Wow`
  String get wow {
    return Intl.message(
      'Wow',
      name: 'wow',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
