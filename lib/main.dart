import 'package:flutter/material.dart';

import 'package:quicklogin/screens/onboarding_screen.dart';
import 'package:quicklogin/utils/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainScreen(loggedIn: false));
}

class MainScreen extends StatelessWidget {
  bool loggedIn;
  MainScreen({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen(loggedin: loggedIn));
  }
}
