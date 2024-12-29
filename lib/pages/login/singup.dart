import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/images_strings.dart';
import '../widgets/loginhead.dart';
import 'loginScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {



  String errorMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController =  TextEditingController();



  Future<void> signin() async {
    final String url = "http://192.168.56.1/damproject/signin.php";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          'username': usernameController.text,
          'phone': phoneController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == "success") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Loginscreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(data['message'] ?? 'An error occurred.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text("Server error: ${response.statusCode}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text("An unexpected error occurred."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeader(
                  image: Logo,
                  title: 'Sign Up ',
                  subTitle: 'Create your profile here ',

                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller : usernameController,
                          decoration: InputDecoration(
                            label: Text(
                              "Full Name",
                              style: GoogleFonts.poppins(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(LineAwesomeIcons.otter),
                            iconColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 13),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            label: Text(
                              "Email",
                              style: GoogleFonts.poppins(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(LineAwesomeIcons.envelope),
                            iconColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 13),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            label: Text(
                              "Password",
                              style: GoogleFonts.poppins(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                            iconColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 13),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            label: Text(
                              "Phone Number",
                              style: GoogleFonts.poppins(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(LineAwesomeIcons.phone),
                            iconColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: signin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "SIGN UP",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Loginscreen()),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account?",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: " log in",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
