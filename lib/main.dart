import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/routes.dart';
import 'package:flutter_firebase_project_app/firebase_options.dart';
import 'package:flutter_firebase_project_app/view/Login_View/login_screen.dart';
import 'package:flutter_firebase_project_app/view/Signup_View/signup_screen.dart';

import 'view/Home_View/home_screen.dart';
import 'view/Splash_View/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.splashScreen) {
          return PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashScreen(),
          );
        }
        if (settings.name == AppRoutes.loginScreen) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const LoginScreen());
        }
        if (settings.name == AppRoutes.signupScreen) {
          return MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          );
        }
        if (settings.name == AppRoutes.homeScreen) {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        }
        return null;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
