
import 'package:flutter/material.dart';
import 'package:foryou/widgets/bar.dart';
import 'package:foryou/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/app_theme_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          image: isDark
              ? null
              : const DecorationImage(
            image: AssetImage(
              "assets/WhatsApp Image 2026-09-03 at 10.39.56 PM.jpeg",
            ),
            repeat: ImageRepeat.repeat,
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),


              // Profile Card


              Container(
                width: 550,
                height: 210,
                margin: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: isDark
                        ? [
                      const Color(0xff303030),
                      const Color(0xff202020),
                    ]
                        : [
                      const Color(0xFF89b9f8),
                      Colors.white,
                    ],
                  ),

                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Profile Image
                    Container(
                      width: 80,
                      height: 80,

                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),

                      child: ClipOval(
                        child: Image.asset(
                          "assets/WhatsApp Image 2026-09-03 at 6.10.41 PM.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Text(
                      "user name",
                      style: TextStyle(
                        color: theme.textTheme.titleLarge?.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    Text(
                      "email",
                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Edit Profile
                    Container(
                      height: 35,
                      width: 100,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: const Color(0xFF89b9f8),
                      ),

                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),

                            SizedBox(width: 5),

                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),


              // Language


              _profileOption(
                context,
                icon: Icons.language,
                title: "Language",
              ),

              const SizedBox(height: 5),


              // Notification


              _profileOption(
                context,
                icon: Icons.notifications,
                title: "Notification",
              ),

              const SizedBox(height: 5),


              // Payment


              _profileOption(
                context,
                icon: Icons.payment,
                title: "Payment",
              ),

              const SizedBox(height: 5),


              // Dark Mode


              Container(
                width: 400,
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: theme.cardColor,

                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black54
                          : Colors.white,
                      blurRadius: 0.5,
                    ),
                  ],

                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 5),

                    Icon(
                      Icons.dark_mode,
                      color: theme.iconTheme.color,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "Dark Mode",
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,
                        fontSize: 20,
                      ),
                    ),

                    const Spacer(),

                    Switch(
                      value:
                      context.watch<AppThemeCubit>().state ==
                          ThemeMode.dark,

                      onChanged: (value) {
                        context
                            .read<AppThemeCubit>()
                            .toggleTheme();
                      },
                    ),

                    const SizedBox(width: 5),
                  ],
                ),
              ),

              const SizedBox(height: 25),


              // Privacy & Policy


              _profileOption(
                context,
                icon: Icons.privacy_tip,
                title: "Privacy & Policy",
              ),

              const SizedBox(height: 5),


              // About Us


              _profileOption(
                context,
                icon: Icons.info,
                title: "About Us",
              ),

              const SizedBox(height: 5),


              // Contact Us

              _profileOption(
                context,
                icon: Icons.phone,
                title: "Contact Us",
              ),

              const SizedBox(height: 25),


              // Logout


              GestureDetector(
                onTap: () async {
                  final prefs =
                  await SharedPreferences.getInstance();

                  await prefs.clear();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },

                child: Container(
                  width: 400,
                  height: 45,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16),

                  decoration: BoxDecoration(
                    color: theme.cardColor,

                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black54
                            : Colors.black,
                        blurRadius: 0.5,
                      ),
                    ],

                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    children: [
                      const SizedBox(width: 5),

                      const Icon(
                        Icons.arrow_circle_left,
                        color: Colors.red,
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),

                      const Spacer(),

                      Icon(
                        Icons.arrow_forward_ios,
                        color: theme.iconTheme.color,
                      ),

                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const Bar(
        currentPage: 'profile',
      ),
    );
  }

  // =========================
  // Profile Option Widget
  // =========================

  Widget _profileOption(
      BuildContext context, {
        required IconData icon,
        required String title,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 400,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        color: theme.cardColor,

        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black54
                : Colors.black,
            blurRadius: 0.5,
          ),
        ],

        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          const SizedBox(width: 5),

          Icon(
            icon,
            color: theme.iconTheme.color,
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 20,
            ),
          ),

          const Spacer(),

          Icon(
            Icons.arrow_forward_ios,
            color: theme.iconTheme.color,
          ),

          const SizedBox(width: 10),
        ],
      ),
    );
  }
}