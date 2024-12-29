
import '/pages/profile/aboutus.dart';
import '/pages/profile/help.dart';
import '/pages/profile/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/images_strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          "Your Profile",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
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
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white10,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.edit,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "superfragilisticexpialidocious",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "NorhaneBenf@gmail.com",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileEdit()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent.shade200,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    "Edit profile",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 30),
              menuprofile(
                title: "Personal Details",
                icon: LineAwesomeIcons.otter,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileEdit()),
                  );
                },
                endIcon: true,
              ),
              menuprofile(
                title: "Favorites",
                icon: LineAwesomeIcons.heart,
                onPress: () {},
                endIcon: true,
              ),
              menuprofile(
                title: "About Us",
                icon: LineAwesomeIcons.info,
                onPress: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Aboutus()),
                );},
                endIcon: true,
              ),
              menuprofile(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                onPress: () {},
                endIcon: true,
                textcolor: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class menuprofile extends StatelessWidget {
  const menuprofile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.endIcon,
    this.textcolor,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white54,
        ),
        child: Icon(icon, color: Colors.black45),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ).apply(color: textcolor),
      ),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white54,
        ),
        child: const Icon(
          LineAwesomeIcons.arrow_circle_right,
          color: Colors.black,
          size: 18,
        ),
      )
          : null,
    );


  }
}
