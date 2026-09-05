import 'dart:async';
import 'package:flutter/material.dart';
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
    checkOnboarding();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),        ),
      );
    });
  }
  Future<void>checkOnboarding()async{
    await Future.delayed(Duration(seconds: 3));
    if(!mounted) return;
    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool('onboarding_seen')?? false;
    if(onboardingSeen){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingPage()));
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
            image: AssetImage(
              'assets/splash_page.jpeg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 270,
                height: 270,
                decoration: BoxDecoration(
                  color: const Color(0xffd4edff),
                  borderRadius: BorderRadius.circular(55),
                ),
                child: const Center(
                  child: Text(
                    'For You',
                    style: TextStyle(
                      fontSize: 55,
                      color: Color(0xff79a9ee),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    child: Divider(color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Divider(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                'Everything you love,',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff666666),
                ),
              ),

              const Text(
                'made for you',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff666666),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}