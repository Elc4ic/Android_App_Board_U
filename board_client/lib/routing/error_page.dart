import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(
      {super.key, required this.errorMessage, required this.errorTitle});

  final String errorMessage;
  final String errorTitle;

  Widget mainScreen(BuildContext context) {
    return Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
          TypewriterAnimatedText(
            curve: Curves.linear,
            speed: const Duration(milliseconds: 100),
            errorTitle,
            textStyle: Theme.of(context).textTheme.titleMedium,
          ),
        ]),
      ),
      body: mainScreen(context),
    );
  }
}