import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome, Fit Boy !", textScaler: TextScaler.linear(2)),
          const Center(
            child: Image(
              image: AssetImage('assets/images/ai_generated/happy_user_2.png'),
            ),
          ),
        ],
      ),
    );
  }
}
