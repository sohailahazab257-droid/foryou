import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatestOutfitPage extends StatelessWidget {
  const LatestOutfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // نفس ألوان Discover Trends
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

                        // ================= الصور =================
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: SizedBox(
                            height: 380,
                            child: Row(
                              children: [
                                // الصورة الكبيرة
                                Expanded(
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    child: Image.asset(
                                      'assets/img1_latest_outfit_page.png',
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.image,
                                            size: 50,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // الصورتين على اليمين
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/img2_latest_outfit_page.png',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                  Icons.image,
                                                  size: 40,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/img3_latest_outfit_page.png',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                  Icons.image,
                                                  size: 40,
                                                ),
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

                        // ================= المؤشرات =================
                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // المؤشر الثالث Active
                            Container(
                              width: 55,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),

                        // ================= العنوان =================
                        const SizedBox(height: 30),

                        const Text(
                          'Latest Outfit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        // ================= الوصف =================
                        const SizedBox(height: 12),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 35,
                          ),
                          child: Text(
                            'Express your self though the art of\nthe fashionism',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ),

                        const Spacer(),

                        // ================= زر السهم =================
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final prefs =
                              await SharedPreferences
                                  .getInstance();

                              await prefs.setBool(
                                'onboarding_seen',
                                true,
                              );

                              if (!context.mounted) return;

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const LoginPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                // نفس لون زر Discover Trends
                                color: const Color(0xff8FC5F5),

                                // نفس لون الـ Border
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