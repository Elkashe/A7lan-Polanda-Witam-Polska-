import 'package:a7lanpopo/core/sharedpref/shared.dart';
import 'package:a7lanpopo/features/constant.dart';
import 'package:a7lanpopo/features/models/onboarding.dart';
import 'package:a7lanpopo/features/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiOnBoarding extends StatefulWidget {
  const UiOnBoarding({super.key});

  @override
  State<UiOnBoarding> createState() => _UiBoardingState();
}

class _UiBoardingState extends State<UiOnBoarding> {
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton.icon(
              onPressed: () {
                CacheHelper.putBool(key: 'onboarding', value: true);
                Navigator.pushReplacementNamed(context, Constant.register);
              },
              label: Text(
                'Skip',
                style: GoogleFonts.abhayaLibre(fontSize: 20),
              ),
              icon: const Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            isLast = index == onboard.length - 1;
          });
        },
        itemCount: onboard.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              OnboardingUi(onBoarding: onboard[index]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Visibility(
                    visible: isLast,
                    child: TextButton.icon(
                      onPressed: () {
                        CacheHelper.putBool(key: 'onboarding', value: true);
                        Navigator.pushReplacementNamed(context, Constant.register);
                      },
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      label: Text(
                        'Next',
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
