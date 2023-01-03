import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view/history_view.dart';
import 'package:todo_dafault/presentation/view/home_view.dart';
import 'package:todo_dafault/presentation/view/on_boarding_view.dart';
import 'package:todo_dafault/presentation/view/profile_view.dart';
import 'package:todo_dafault/presentation/view/sign_in_view.dart';
import 'package:todo_dafault/presentation/view/sign_up_view.dart';
import 'package:todo_dafault/presentation/view/task_detail_view.dart';
import 'package:todo_dafault/presentation/view/widget/bottom_navbar.dart';
import 'package:todo_dafault/injection.dart' as di;
import 'package:todo_dafault/presentation/view_model/auth_view_model.dart';
import 'package:todo_dafault/presentation/view_model/counter_view_model.dart';
import 'package:todo_dafault/presentation/view_model/preferences_view_model.dart';
import 'package:todo_dafault/presentation/view_model/task_view_model.dart';

import 'domain/entities/task.dart';

Future main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? isOnBoardingViewed = sharedPreferences.getBool('onBoarding');

  if (isOnBoardingViewed == true) {
    runApp(const MyApp(
      initialRoute: SignInView.routeName,
    ));
  } else if (isOnBoardingViewed == false) {
    runApp(const MyApp(
      initialRoute: OnBoardingView.routeName,
    ));
  } else if (isOnBoardingViewed == null) {
    runApp(const MyApp(
      initialRoute: OnBoardingView.routeName,
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({required this.initialRoute, super.key});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TaskViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CounterViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PreferenceViewModel>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: darkBlue,
        ),
        initialRoute: initialRoute,
        routes: {
          OnBoardingView.routeName: (context) => const OnBoardingView(),
          SignInView.routeName: (context) => const SignInView(),
          SignUpView.routeName: (context) => const SignUpView(),
          HistoryView.routeName: (context) => const HistoryView(),
          HomeView.routeName: (context) => const HomeView(),
          ProfileView.routeName: (context) => const ProfileView(),
          BottomNavbar.routeName: (context) => const BottomNavbar(),
          TaskDetailView.routeName: (context) => TaskDetailView(
                task: (ModalRoute.of(context)?.settings.arguments as Task),
              ),
        },
      ),
    );
  }
}
