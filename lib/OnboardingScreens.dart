import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navigation/BasePage.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  double currentPage = 0;
  final TextEditingController _inputController = TextEditingController();
  List restaurants = [];
  String message = '';

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  String cleanRegionText(String rawText) {
    return rawText
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z\s]'), '');
  }

  Future<void> fetchRestaurants(String region) async {
    var response = await http.get(
        Uri.parse("http://192.168.56.1/damproject/getrestaurant.php?region=$region"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == "success") {
        setState(() {
          message = '';
          restaurants = data['data'];
          print(restaurants);
        });
      } else {
        setState(() {
          message = data['message'] ?? 'An error occurred, please try again.';
          print(message);
        });
      }
    }
  }

  void _navigateToNextScreen() async {
    if (currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      String region = cleanRegionText(_inputController.text);
      await fetchRestaurants(region);
      if (message == '') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BasePage(
              region: region,
              restaurants: restaurants,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Image.asset(
                      'assets/images/traveleatlogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          PageView(
            controller: _pageController,
            children: [
              _buildPage(
                "Welcome to Traveat!",
                "Discover features that make your eating journey easier.",
                'assets/images/onboarding.png',
                true,
              ),
              _buildPage(
                "Choose your City",
                "     ",
                'assets/images/algeriamap.png',
                false,
              ),
            ],
          ),

          if (currentPage >= 1)
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(

                    ),
                    child: TextField(
                      controller: _inputController,
                      cursorColor: Colors.amber,
                      decoration: InputDecoration(
                        hintText: 'Enter your city',
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.amber[100]?? Colors.amber,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.amber[100]?? Colors.amber,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: DotsIndicator(
                dotsCount: 2,
                position: currentPage,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  activeColor: Colors.amber[200],
                  spacing: const EdgeInsets.all(4),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 35,
            right: 35,
            child: Center(
              child: ElevatedButton(
                onPressed: _navigateToNextScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  currentPage < 1 ? "Next" : "Start",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String subtitle, String imagePath, bool isFirstPage) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}