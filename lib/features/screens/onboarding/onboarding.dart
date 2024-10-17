import 'package:a7lanpopo/features/constant.dart';
import 'package:a7lanpopo/features/models/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnboardingUi extends StatelessWidget {
  OnBoarding onBoarding;
   OnboardingUi({super.key, required this.onBoarding});
   
     

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(onBoarding.image, fit: BoxFit.cover ,height: 450),
        SmoothPageIndicator(
          effect: const JumpingDotEffect(
              dotHeight: 16,
              dotWidth: 16,
              jumpScale: .5,
              verticalOffset: 10,),
          controller: pageController,
          count: onboard.length,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          onBoarding.des,
          style: GoogleFonts.abhayaLibre(fontSize: 30),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
            child: Text(
          onBoarding.title,
          style: GoogleFonts.abhayaLibre(fontSize: 20),
        ))
      ],
    );
  }
}