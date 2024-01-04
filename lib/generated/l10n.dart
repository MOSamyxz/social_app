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

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
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

  /// `Your name`
  String get yourName {
    return Intl.message(
      'Your name',
      name: 'yourName',
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

  /// `Please enter a Password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter a Password',
      name: 'pleaseEnterPassword',
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

  /// `re-Password`
  String get rePassword {
    return Intl.message(
      're-Password',
      name: 'rePassword',
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
