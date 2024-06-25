import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/pages/settings/widgets/setting_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Plolicy'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SettingCategory(
              title: 'Privacy Policy for 7war App',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              text:
                  'This Privacy Policy describes how We collects, uses, and shares personal information when you use our social media app.',
              richText: false,
            ),
            SettingCategory(
              title: 'Information We Collect',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Account Information: ',
              body:
                  'When you create an account on 7war App, we may collect your name, username, email address, and profile picture.',
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'User-Generated Content: ',
              body:
                  'We may collect the content, posts, photos, videos, and other materials that you upload or share on 7war App.',
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Usage Data: ',
              body:
                  'We may collect information about how you interact with our app, including your interactions with other users, groups, and communities.',
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Device Information: ',
              body:
                  'We may collect information about the device you use to access our app, including the device type, operating system, and unique device identifiers.',
            ),
            SettingCategory(
              title: 'How We Use Your Information',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Personalization: ',
              body:
                  'We use the information we collect to personalize your experience on 7war App, including showing you relevant content and recommendations.',
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Communication: ',
              body:
                  'We may use your contact information to communicate with you about your account, updates to our app, and promotional offers.',
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Analytics: ',
              body:
                  'We use data analytics to understand how users interact with our app and to improve our services.',
            ),
            SettingCategory(
              title: 'Sharing of Information',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Public Content: ',
              body:
                  'Any content that you share publicly on 7war App may be visible to other users and the public.',
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: true,
              leading: 'Third-Party Service Providers: ',
              body:
                  'We may share your information with third-party service providers who assist us in providing and improving our app.',
            ),
            SettingCategory(
              title: 'Data Security',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: false,
              text:
                  'We take reasonable measures to protect the security and integrity of your personal information. However, no method of transmission over the internet or electronic storage is 100% secure.',
            ),
            SettingCategory(
              title: 'Your Choices',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: false,
              text:
                  'You can manage your account settings and privacy preferences within 7war App. You may also have the option to delete your account and associated data.',
            ),
            SettingCategory(
              title: 'Changes to This Privacy Policy',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: false,
              text:
                  'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
            ),
            SettingCategory(
              title: 'Contact Us',
              fontWeight: FontWeight.bold,
            ),
            PrivacyPolicyTermsConditionsInfo(
              richText: false,
              text:
                  'If you have any questions about this Privacy Policy, please contact us at Support@7war.com',
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyTermsConditionsInfo extends StatelessWidget {
  const PrivacyPolicyTermsConditionsInfo({
    super.key,
    this.text,
    required this.richText,
    this.leading,
    this.body,
  });
  final String? text;
  final String? leading;
  final String? body;
  final bool richText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s5),
      padding: const EdgeInsets.symmetric(vertical: AppSize.s5),
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color),
      child: Padding(
        padding: AppPadding.screenPadding,
        child: richText
            ? RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: leading,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: body,
                    ),
                  ],
                ),
              )
            : Text(text!),
      ),
    );
  }
}
