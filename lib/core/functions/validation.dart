import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/generated/l10n.dart';

validInput(String val, min, max, String type, context) {
  if (type == 'empty') {
    if (val.isEmpty) {
      return S.of(context).emailMustNotBeEmpty;
    }
  }
  if (type == 'email') {
    if (val.isEmpty) {
      return S.of(context).emailMustNotBeEmpty;
    } else if (!isEmail(val)) {
      return S.of(context).pleaseEnterAValidEmail;
    }
  }
  if (type == 'password') {
    if (val.isEmpty) {
      return S.of(context).pleaseEnterPassword;
    } else if (val.length < min) {
      return S.of(context).shortPassword;
    } else if (val.length > max) {
      return S.of(context).longPassword;
    }
  }
  if (type == 'gender') {
    if (val.isEmpty) {
      return S.of(context).genderCantBeEmpty;
    }
  }
  if (type == 'username') {
    if (val.isEmpty) {
      return S.of(context).pleaseEnterUserName;
    } else if (!isValidUsername(val)) {
      return S.of(context).pleaseEnterValidUserName;
    }
  }
}
