import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed('/auth');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Hero(
              tag: "logo",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundImage: AssetImage('assets/images/logo.gif'),
                radius: 55,
              ),
            ),
            const SizedBox(height: 30),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Home Automation',
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  speed: const Duration(milliseconds: 40),
                ),
              ],
              isRepeatingAnimation: false,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
