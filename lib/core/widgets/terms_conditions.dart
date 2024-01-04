import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
              text: '${S.of(context).bySigningUpYouAgreeToOur} ',
              style: AppStyles.font14RegularlighterBlack),
          TextSpan(
              text: '${S.of(context).termsConditions} ',
              style: AppStyles.font14MediumlighterBlack),
          TextSpan(
              text: '${S.of(context).and} ',
              style: AppStyles.font14RegularlighterBlack),
          TextSpan(
              text: '${S.of(context).privacyPolicy} ',
              style: AppStyles.font14MediumlighterBlack),
        ],
      ),
    );
  }
}
