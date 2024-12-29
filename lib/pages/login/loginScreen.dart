import '/pages/login/singup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants/images_strings.dart';
import '../../constants/size.dart';
import '../../home/HomePage.dart';
import '../../GetStartedPage.dart';
import 'dart:convert';
import '../favorite.dart';
import '../../home/HomePage.dart';
import '../../constants/text.dart';
import '../profile/profile.dart';
import 'package:damproject/user/userprovider.dart';
class Loginscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(defaultsize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(Logo), height: size.height * 0.2),
              Text(
                welcome,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                welcomesub,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Loginform(),
            ],
          ),
        ),
      ),
    );
  }
}

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {




  String message = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? isRememberMe = false;


  Future<void> login() async {
    final String url = "http://192.168.56.1/damproject/login.php";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Decoded data: $data');
      if (data['status'] == "success") {
        final user = data['user'];
        final username = user['username'];
        final email = user['email'];
        final image = user['image'];
        final location = user['location'];
        context.read<userprovider>().setemail(email);
        context.read<userprovider>().setusername(username);
        context.read<userprovider>().setimage(image);
        context.read<userprovider>().setlocation(location);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GetStartedPage(),
          ),
        );

      } else {
        setState(() {
          message = data['message'] ?? 'An error occurred, please try again.';
        });
      }
    }else {
      setState(() {
        message = "Error: ${response.statusCode}";
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(LineAwesomeIcons.envelope),

                labelText: temail,
                hintText: temail,
                labelStyle: GoogleFonts.poppins(),
                hintStyle: GoogleFonts.poppins(),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: 1),
                ),

              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(LineAwesomeIcons.fingerprint),
                labelText: tpassword,
                hintText: tpassword,
                labelStyle: GoogleFonts.poppins(),
                hintStyle: GoogleFonts.poppins(),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: 1),
                ),

                suffixIcon: IconButton(
                  onPressed: null,
                  icon: const Icon(LineAwesomeIcons.eye_1),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              message,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.red ,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:  login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "LOGIN",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Singup()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
