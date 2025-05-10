import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingData = [
      {
        'image': 'assets/onboarding1.png',
        'text': '인지 치료 챗봇에 오신 것을 환영합니다!'
      },
      {
        'image': 'assets/onboarding2.png',
        'text': '중독으로부터 고통받고 있는 여러분들을 위해 준비했어요.'
      },
      {
        'image': 'assets/onboarding3.png',
        'text': '각 분야 전문가 버디가 상담을 도와줄 거예요.'
      },
      {
        'image': 'assets/onboarding4.png',
        'text': '무제한으로 버디들과 얘기해보세요!'
      },
    ];

    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(onboardingData[index]['image']!),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  onboardingData[index]['text']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text("알겠습니다"),
              )
            ],
          );
        },
      ),
    );
  }
}
