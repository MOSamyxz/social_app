import 'package:chatapp/core/constants/colors.dart';
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
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkGreyColor,
                  )),
          TextSpan(
              text: '${S.of(context).termsConditions} ',
              style: Theme.of(context).textTheme.bodyMedium),
          TextSpan(
              text: '${S.of(context).and} ',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkGreyColor,
                  )),
          TextSpan(
              text: '${S.of(context).privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
