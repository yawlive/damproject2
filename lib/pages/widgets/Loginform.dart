import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/text.dart';

class Loginform1 extends StatelessWidget {
  const Loginform1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(LineAwesomeIcons.envelope),
                labelText: temail,
                hintText: temail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                labelText: tpassword,
                hintText: tpassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(LineAwesomeIcons.eye_1),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {Navigator.pop(context);},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Sing up"),
              ),
            ),
            const SizedBox(height: 10,),

          ],
        ),
      ),
    );}}