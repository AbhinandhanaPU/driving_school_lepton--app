import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoadingWidet extends StatelessWidget {
  const LottieLoadingWidet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Lottie.asset(
          'assets/lottie_files/Animation - 1725617166634.json',
          width: 50,
          height: 40,
        ),
      ),
    );
  }
}
