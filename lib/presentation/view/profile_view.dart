import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view/sign_in_view.dart';

import '../view_model/preferences_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = '/profile_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<PreferenceViewModel>(
                        builder: (context, provider, child) {
                          return Text(
                            provider.name,
                            style: headline3,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Edit Profile',
                        style: overline.copyWith(
                          color: blue,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkGrey,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              profileMenu('Reset Password', 'assets/images/security.png'),
              profileMenu('Delete Account', 'assets/images/account.png'),
              profileMenu('Privacy & Policy', 'assets/images/paper.png'),
              profileMenu('About', 'assets/images/about.png'),
              const SizedBox(
                height: 64,
              ),
              Center(
                child: SizedBox(
                  height: 52,
                  width: 157,
                  child: Consumer<PreferenceViewModel>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(31),
                          ),
                        ),
                        child: Text(
                          'Sign Out',
                          style: button,
                        ),
                        onPressed: () async {
                          await value.logouts().whenComplete(
                                () => Navigator.pushReplacementNamed(
                                  context,
                                  SignInView.routeName,
                                ),
                              );
                          value.setOnBoardingPreference(true);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileMenu(String title, String icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: task,
            ),
            // ignore: no-empty-block
            onPressed: () {},
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 22.0,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(title, style: button.copyWith(letterSpacing: 0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
