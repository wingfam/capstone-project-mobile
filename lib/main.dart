import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/firebase_options.dart';
import 'loading_config.dart';
import 'services/auth/auth_service.dart';
import 'constants/routes.dart';
import 'views/history_screen/history.dart';
import 'views/home_screen/home.dart';
import 'views/information_screen/profile.dart';
import 'views/login_screen/login.dart';
import 'views/notification_screen/notification.dart';
import 'views/register_screen/register.dart';
import 'views/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      builder: EasyLoading.init(),
      routes: <String, WidgetBuilder>{
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        mainViewRoute: (context) => const MainView(),
        homeRoute: (context) => const HomeScreen(),
        notificationRoute: (context) => const Noti(),
        historyRoute: (context) => const History(),
        profileRoute: (context) => const Info(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user?.email != null) {
              return const MainView();
            } else {
              return const LoginScreen();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
