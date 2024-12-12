import 'package:flutter/material.dart';


class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 140,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 50),
            const Text(
              "Reconnect with Faith",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Log in to explore daily verses, upload prayers, and deepen your spiritual journey.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // login actions
            LoginButton(
              title: 'Continue With Google',
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            LoginButton(
              title: 'Continue With Facebook',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const LoginButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        decoration: BoxDecoration(
          color: Colors.grey.shade300, // Background color
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 140,
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 50),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
