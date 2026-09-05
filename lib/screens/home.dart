import 'package:flutter/material.dart';
import 'package:foryou/widgets/product.dart';
import 'package:foryou/widgets/bar.dart';
import 'package:foryou/screens/favorit.dart';
void main() {
  runApp(const Home());
}
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  int currentPage = 0;

  Widget buildOfferBanner(String image) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            left: 23,
            top: 30,
            child: Text(
              'GET 30% OFF',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Positioned(
            left: 25,
            top: 72,
            child: Text(
              'Limited Offer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            left: 25,
            bottom: 25,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'SHOP NOW',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffd4edff),
          title: Row(
            children: [
              Container(
                width: 50,
                height: 50,
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
              const SizedBox(width: 10),
              Column(
                children: const [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Color(0xff6a6a6a),
                      fontSize: 15,
                    ),
                  ),
//$firstName $lastname
                  Text(
                    "user name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 142),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffd4edff),
                  border: Border.all(
                    color: const Color(0xff89b9f8),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fav(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.bookmark,
                    color: Color(0xff89b9f8),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/WhatsApp Image 2026-09-03 at 10.39.56 PM.jpeg"),
              repeat: ImageRepeat.repeat,
            ),
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 350,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0x30ffffff),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff6a6a6a),
                    ),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 15),
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "What's on your list?",
                        style: TextStyle(
                          color: Color(0xff6a6a6a),
                        ),
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
                      buildOfferBanner(
                        "assets/WhatsApp Image 2026-09-03 at 10.19.17 PM.jpeg",
                      ),
                      buildOfferBanner(
                        "assets/WhatsApp Image 2026-09-03 at 10.19.17 PM.jpeg",
                      ),
                      buildOfferBanner(
                        "assets/WhatsApp Image 2026-09-03 at 10.19.17 PM.jpeg",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                        (index) {
                      return AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        width: currentPage == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? Colors.black
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const CategoriesProducts(),
              ],
            ),
          ),
        ),

        bottomNavigationBar: const Bar(currentPage: 'home'),
      ),
    );
  }
}