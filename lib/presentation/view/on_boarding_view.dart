import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view/sign_in_view.dart';

import '../view_model/preferences_view_model.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  static const routeName = '/onboarding_view';

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final emptySpace = pageHeight - 396;

    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: emptySpace * 0.10,
              ),
              Image.asset('assets/images/Ilustrasi.png'),
              SizedBox(
                height: emptySpace * 0.20,
              ),
              Text('Managed Your\nSchedule Easily', style: headline1),
              SizedBox(
                height: emptySpace * 0.30,
              ),
              SizedBox(
                width: 157,
                height: 52,
                child: Consumer<PreferenceViewModel>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(31),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: button,
                      ),
                      onPressed: () {
                        bool value = true;
                        provider.setOnBoardingPreference(value);
                        Navigator.pushReplacementNamed(
                          context,
                          SignInView.routeName,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
