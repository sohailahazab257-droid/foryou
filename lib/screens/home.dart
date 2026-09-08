import 'package:flutter/material.dart';
import 'package:foryou/widgets/buildofferbanner.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:foryou/widgets/product.dart';
import 'package:foryou/widgets/bar.dart';
import 'package:foryou/screens/favorit.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.userName = ''});

  final String userName;

  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  int currentPage = 0;
  String displayName = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    if (widget.userName.isNotEmpty) {
      setState(() {
        displayName = widget.userName;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name');

    if (savedName != null && savedName.isNotEmpty) {
      setState(() {
        displayName = savedName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  "assets/WhatsApp Image 2026-09-03 at 6.10.41 PM.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 15,
                  ),
                ),

                Text(
                  displayName,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,

                border: Border.all(color: const Color(0xff89b9f8), width: 1),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fav()),
                  );
                },
                icon: const Icon(Icons.bookmark, color: Color(0xff89b9f8)),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,

        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 350,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(width: 1, color: const Color(0xff6a6a6a)),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 15),

                    Icon(Icons.search, color: Colors.black),

                    SizedBox(width: 10),

                    Text(
                      "What's on your list?",
                      style: TextStyle(color: Color(0xff6a6a6a)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 220,
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    Buildofferbanner(
                      image:
                          "assets/WhatsApp Image 2026-09-03 at 10.19.17 PM.jpeg",
                    ),
                    Buildofferbanner(
                      image:
                          "assets/WhatsApp Image 2026-09-03 at 10.19.17 PM.jpeg",
                    ),
                    Buildofferbanner(
                      image:
                          "assets/WhatsApp Image 2026-09-03 at 10.19.17 PM.jpeg",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.black
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              const CategoriesProducts(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const Bar(currentPage: 'home'),
    );
  }
}
