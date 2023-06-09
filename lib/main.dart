import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/firebase_options.dart';

import 'views/home_screen/homescreen.dart';
import 'views/information_screen/change_password.dart';
import 'views/information_screen/edit_info.dart';
import 'views/login_screen/login_screen.dart';
import 'views/register_screen/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        // '/': (context) => const Change_Password(),
        '/': (context) => const LoginScreen(),
        '/signUpScreen': (context) => const SignUpScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        // '/taskHistory': (context) => const History(),
        '/editProfile': (context) => const EditInfo(),
        '/changePassword': (context) => const ChangePassword(),
      },
    );
  }
}
