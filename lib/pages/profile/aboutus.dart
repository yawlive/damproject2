import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_double_left),
        ),
        title: Text(
          "About Us",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Our App",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "We are dedicated to providing the best experience for our users. Our mission is to create innovative solutions that make your life easier and more enjoyable.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Our Team",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Our team consists of passionate individuals who are experts in their fields. We work together to bring you the best products and services.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Our Vision",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Our vision is to revolutionize the way people discover and enjoy local dining experiences. We aim to be the go-to platform for users to effortlessly find the perfect restaurant in their area, whether they're craving a specific cuisine or planning a family gathering. By providing a comprehensive list of restaurants across various categories, we strive to make every meal a memorable one.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Contact Us",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "If you have any questions or need support, feel free to reach out to us. We are here to help!",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),


              const SizedBox(height: 20),
              TextButton(
                onPressed: () {


                },
                child: Text(
                  "Contact Us",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

