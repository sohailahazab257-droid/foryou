import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondary,
              AppColors.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: SizedBox(
                            height: 380,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      'صوره البنت اللي بجاكيت بني',
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: AppColors.lightGrey,
                                          child: Icon(
                                            Icons.image,
                                            size: 50,
                                            color: AppColors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.asset(
                                            'صوره الجواكيت',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: AppColors.lightGrey,
                                                child: const Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: AppColors.grey,
                                                ),
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
                                            'صوره اللابتوب',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: AppColors.lightGrey,
                                                child: const Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: AppColors.grey,
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

                        SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 12),
                            Container(
                              width: 35,
                              height: 7,
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 12),
                            Container(
                              width: 55,
                              height: 7,
                              decoration: BoxDecoration(
                                color: AppColors.dark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),


                        Text(
                          'Latest Outfit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),

                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            'Express your self though the art of\nthe fashionism',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.grey,
                              height: 1.4,
                            ),
                          ),
                        ),

                        Spacer(),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: GestureDetector(
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('onboarding_seen',true);
                              if (!context.mounted)return;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                                border: Border.all(
                                  color: AppColors.secondary,
                                  width: 12,
                                ),
                              ),
                              child: Icon(
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