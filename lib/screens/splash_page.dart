import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foryou/home/home.dart';
import 'package:foryou/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkAppState();
  }

  Future<void> checkAppState() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();

    final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    // يبقى اول مره يفتح الابلكيشن
    if (!onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    }
    // لو اليوزر شاف onboardingو عمل log in خلاص
    else if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
    // ال onboarding اتشاف بس اليوزر معملش log in
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_page.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/for You Logo.png',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              // -------------------------------------------------------------------------

              const SizedBox(height: 25),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 120, child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 120, child: Divider(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                'Everything you love,',
                style: TextStyle(fontSize: 20, color: Color(0xff666666)),
              ),

              const Text(
                'made for you',
                style: TextStyle(fontSize: 20, color: Color(0xff666666)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}