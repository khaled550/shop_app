import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shop_app/ui/page/home_page.dart';
import 'package:shop_app/utils/components.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: introScreen(context),
    );
  }

  Widget introScreen(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: IntroductionScreen(
            pages: [
              introPages('assets/images/intro_1.png'),
              introPages('assets/images/intro_2.png'),
              introPages('assets/images/intro_3.png'),
            ],
            onDone: () {
              //navigateTo(context, const HomePage());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            showBackButton: false,
            showSkipButton: true,
            next: const SizedBox(),
            skip: const Text("Skip"),
            done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      );
}
