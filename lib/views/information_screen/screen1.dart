import 'package:flutter/material.dart';

import '../../constants/routes.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen 1"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) {
              return route.settings.name == editProfileRoute;
            });
          },
          child: const Text("Chuyển lại Edit Profile"),
        ),
      ),
    );
  }
}
