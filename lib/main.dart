import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/routes.dart';
import 'package:flutter_firebase_project_app/firebase_options.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/Chat_screen.dart';
import 'package:flutter_firebase_project_app/view/Login_View/login_screen.dart';
import 'package:flutter_firebase_project_app/view/Signup_View/signup_screen.dart';

import 'view/Home_View/home_screen.dart';
import 'view/Splash_View/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
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
        Widget? screen;
        Object? args = settings.arguments;

        switch (settings.name) {
          case AppRoutes.splashScreen:
            screen = const SplashScreen();
            break;
          case AppRoutes.loginScreen:
            screen = const LoginScreen();
            break;
          case AppRoutes.signupScreen:
            screen = const SignupScreen();
            break;
          case AppRoutes.homeScreen:
            screen = const HomeScreen();
            break;
          case AppRoutes.chatScreen:
            screen = ChatScreen(uid: args as String);
            break;
        }

        return screen != null
            ? PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = 0.0;
                  var end = 1.0;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return FadeTransition(
                    opacity: animation.drive(tween),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    screen!,
              )
            : null;
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == AppRoutes.splashScreen) {
      //     return PageRouteBuilder(
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //         return FadeTransition(
      //           opacity: animation,
      //           child: child,
      //         );
      //       },
      //       pageBuilder: (context, animation, secondaryAnimation) =>
      //           const SplashScreen(),
      //     );
      //   }
      //   if (settings.name == AppRoutes.loginScreen) {
      //     return PageRouteBuilder(
      //         pageBuilder: (context, animation, secondaryAnimation) =>
      //             const LoginScreen());
      //   }
      //   if (settings.name == AppRoutes.signupScreen) {
      //     return MaterialPageRoute(
      //       builder: (context) => const SignupScreen(),
      //     );
      //   }
      //   if (settings.name == AppRoutes.homeScreen) {
      //     return MaterialPageRoute(
      //       builder: (context) => const HomeScreen(),
      //     );
      //   }
      //   if (settings.name == AppRoutes.chatScreen) {
      //     final args = settings.arguments;
      //     return MaterialPageRoute(
      //       builder: (context) => ChatScreen(
      //         uid: args as String,
      //       ),
      //     );
      //   }
      //   return null;
      // },
      title: 'CONVO CONNECT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
