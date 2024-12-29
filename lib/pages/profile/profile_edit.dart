
import '/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/images_strings.dart';
import 'help.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

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
          "Edit Profile",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Optional: Set the text color
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
            icon: const Icon(LineAwesomeIcons.question_circle_1),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(Profilepic)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white10,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.camera,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Full Name"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(LineAwesomeIcons.otter),
                        iconColor: Colors.black87,
                        labelStyle: TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(LineAwesomeIcons.envelope),
                        iconColor: Colors.black87,
                        labelStyle: TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                        iconColor: Colors.black87,
                        labelStyle: TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Phone Number"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(LineAwesomeIcons.phone),
                        iconColor: Colors.black87,
                        labelStyle: TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          "Save Changes",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
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
    );
  }
}
