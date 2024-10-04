import 'package:fitfoot/presentation/profile/screens/community_guidlines.dart';
import 'package:fitfoot/presentation/profile/screens/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/account_list_item.dart';
import '../widgets/logout_button.dart';
import '../widgets/logout_dialogue.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Function to launch email
  void _launchEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': 'Feedback',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      _showNoEmailClientDialog();
    }
  }

// Function to show a dialog if no email client is available
  void _showNoEmailClientDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Email App Found'),
          content:
          const Text('Please configure an email app to send feedback.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to launch a URL
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                const ProfileCard(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Support',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 14.sp)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Column(
                          children: [
                            AccountListItem(
                              title: 'Send Feedback',
                              iconPath: 'assets/icons/profile_icons_mail.svg',
                              onTap: () {
                                _launchURL(
                                    'https://sites.google.com/view/fit foot/support');
                              },
                            ),
                            AccountListItem(
                              title: 'Customer Support',
                              iconPath:
                                  'assets/icons/profile_icons_support.svg',
                              onTap: () {
                                _launchURL(
                                    'https://sites.google.com/view/fit foot/support');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text('Others',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 14.sp)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Column(
                          children: [
                            AccountListItem(
                              title: 'Community Guidelines',
                              iconPath: 'assets/icons/profile-icons-faqs.svg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CommunityGuidelines()),
                                );
                                // Open terms of service URL
                                // _launchURL(
                                //     'https://sites.google.com/view/refine-ai-terms/terms-of-service');
                              },
                            ),
                            AccountListItem(
                              title: 'Privacy & Policy',
                              iconPath:
                                  'assets/icons/profile-icons-security.svg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
                                );
                                // Open privacy policy URL
                                // _launchURL(
                                //     'https://sites.google.com/view/refine-ai/privacy-policy');
                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: LogoutButton(
                    onPressed: () async {
                      showLogoutDialog(context);
                    },
                    iconAssetPath: 'assets/icons/logout.svg',
                    text: 'Logout',
                    isIcon: true,
                    gradient: AppColors.secondaryGradient,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
