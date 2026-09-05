import 'package:flutter/material.dart';
import 'discover_trends_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffEAF8FF),
              Color(0xffDDF3FF),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // معرض الصور
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: SizedBox(
                            height: 380, // تقليل الارتفاع يناسب مختلف الشاشات
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      'assets/img1_onboarding.jpeg',
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.image, size: 50),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/img2_onboarding.jpeg',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.image, size: 40),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/img3_onboarding.jpeg',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.image, size: 40),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // مؤشرات الصفحات
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 55,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // العنوان
                        const Text(
                          'Your Own Style',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // الوصف
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            'Smart, gorgeous & fashionable\ncollection makes you cool',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ),

                        const Spacer(),

                        // زر السهم
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DiscoverTrendsPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff8FC5F5),
                                border: Border.all(
                                  color: const Color(0xffC9E3FF),
                                  width: 12,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}