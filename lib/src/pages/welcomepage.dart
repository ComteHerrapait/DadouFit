import 'package:dadoufit/src/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.translations.welcomeFitBoy,
            textScaler: TextScaler.linear(2),
          ),
          const Center(
            child: Image(
              image: AssetImage('assets/images/ai_generated/happy_user_1.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                context.translations.generatedByDallE,
                textScaler: TextScaler.linear(0.75),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(context.translations.doinsportApiWarning),
          ),
        ],
      ),
    );
  }
}
