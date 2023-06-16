import 'package:flutter/material.dart';

import '../../constants/routes.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen 2"),
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
