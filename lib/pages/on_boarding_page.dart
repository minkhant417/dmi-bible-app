import 'package:flutter/material.dart';

import 'log_in_page.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Embrace Daily Devotionals",
      "subtitle":
          "Dive into inspiring devotionals and follow tailored reading plans to enrich your spiritual path",
    },
    {
      "title": "Connect Through Prayer",
      "subtitle":
          "Share your prayers and read uplifting testimonials from fellow believers to strengthen your faith.",
    },
    {
      "title": "Discover Verses of Moment",
      "subtitle":
          "Access the full Bible and find powerful verses to guide you throgh life's challenges.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: onboardingData[index]['title']!,
                    subtitle: onboardingData[index]['subtitle']!,
                  );
                },
              ),
            ),
            // dotted navigator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(isActive: index == _currentPage),
              ),
            ),
            const SizedBox(height: 20),

            //control button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // skip button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogIn()));
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // go to next page
                      if (_currentPage < onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                      // go to login page after finish
                      else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()));
                      }
                    },
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? "Finish"
                          : "Next",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isActive ? const Color.fromARGB(255, 101, 101, 101) : Colors.grey,
      ),
    );
  }
}
