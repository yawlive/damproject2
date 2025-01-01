import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/home/HomePage.dart';
import 'package:http/http.dart' as http;
import 'navigation/BasePage.dart';
import 'user/userprovider.dart';
import 'dart:convert';

class GetStartedPage extends StatefulWidget {
  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  List restaurants=[];

  @override



  String message='';
  Future<void> fetchRestaurants(String region) async {

    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getrestaurant.php?region=$region"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if  (data['status'] == "success") {
      setState(() {
        message='';
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


  TextEditingController regioncontroller = TextEditingController();

  String cleanRegionText(String rawText) {
    return rawText
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z\s]'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Center(
                child: Image.asset('assets/images/traveleatlogo.png',

                  fit: BoxFit.cover,
                ),

              ),

            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // first image container
                Expanded(
                 // padding: const EdgeInsets.all(8.0),
                  child: Container(
                   // color: Colors.red,
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left: 20),


                   // height: 350,
                  //  width: 240,
                    child: Center(
                      child: Image.asset(
                        'assets/images/plats.png',

                        fit: BoxFit.contain,
                      ),

                    ),

                  ),
                ),
                  SizedBox(width: 1,),

                // bubble container maybe stack?
                Container(
                 // color: Colors.blue,
                  height: 100,
                  width: 200,
                  child: Center(

                    child: Column(
                      children: [
                        SizedBox(height: 17,),
                        Text("Welcome !",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            )

                        ),
                        Text("Let us help you choose ",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                //  fontSize: 10,
                                  fontWeight: FontWeight.w300
                              ),
                            )),

                      ],
                    ),

                  ),


                )
              ],
            ),





            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
               // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Column(
                    children: [
                      Text( message,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              //  fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.red,

                            ),
                          )),
                      SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 200,

                    child:
                    TextField(
                      controller: regioncontroller,
                      decoration: InputDecoration(
                        hintText: 'Enter your city',
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            //  fontSize: 15,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        filled: true,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),


                  ),
                    ],
                  ),
                ],

              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () async {
                String region = cleanRegionText(regioncontroller.text);
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
              },
              child: Container(
                width: 90,
                height: 40,
                margin: EdgeInsets.only(left:250,),
                //padding:  EdgeInsets.only(left: 10,top: 10, bottom: 10,right: 10),
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ),

            SizedBox(height: 32),

          ],
        ),
      ),
    );
  }
}
