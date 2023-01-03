import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/presentation/view/sign_up_view.dart';
import 'package:todo_dafault/presentation/view/widget/bottom_navbar.dart';
import 'package:todo_dafault/presentation/view_model/auth_view_model.dart';

import '../view_model/preferences_view_model.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static const routeName = '/sign_in_view';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign In', style: headline2),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Sign In to Continue',
              style: overline,
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email Address', style: button),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: textField,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/email_icon.png',
                      width: 17,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: overline.copyWith(color: milkWhite),
                        controller: emailController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Email Address',
                          hintStyle: overline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ignore: long-method
    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: button,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: textField,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/password_icon.png',
                      width: 17,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: overline.copyWith(
                          color: milkWhite,
                        ),
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Password',
                          hintStyle: overline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ignore: long-method
    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: Consumer<PreferenceViewModel>(
          builder: (
            context,
            provider,
            child,
          ) {
            return ElevatedButton(
              onPressed: () async {
                if (await authViewModel.userSignIn(
                  emailController.text,
                  passwordController.text,
                )) {
                  final token = authViewModel.user.token;
                  final name = authViewModel.user.data.name;
                  final email = emailController.text;

                  log(token);
                  provider.setNamePreference(name);
                  provider.setTokenPreference(token);
                  provider.setEmailPreference(email);

                  Navigator.pushReplacementNamed(
                    context,
                    BottomNavbar.routeName,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: darkGrey,
                      content: Text(
                        'Sign In success',
                        style: overline.copyWith(color: white),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: darkGrey,
                      content: Text(
                        'Sign In Failed',
                        style: overline.copyWith(color: white),
                      ),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Sign In', style: button),
            );
          },
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account? ',
              style: overline.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignUpView.routeName);
              },
              child: Text(
                'Sign Up',
                style: overline.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: blue,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              emailInput(),
              passwordInput(),
              signInButton(),
              const Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
