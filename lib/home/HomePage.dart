import 'package:carousel_slider/carousel_slider.dart';
import '../pages/profile/profile.dart';
import 'package:damproject/user/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../categories/All.dart';
import'../pages/login/loginScreen.dart';
import '../GetStartedPage.dart';
import '../categories/Cafeteria.dart';
import '../categories/Fastfood.dart';
import '../categories/FineDining.dart';
import '../categories/Grills.dart';
import '../categories/Pizza.dart';
import '../home/RestaurantPicks.dart';
import 'dart:convert';
import '../pages/login/firstpage.dart';
import 'package:provider/provider.dart';
import '../pages/favorite.dart';
import '../user/userprovider.dart';
class  HomePage extends StatefulWidget {
  final String region;
  final List restaurants;
  HomePage({required this.region, required this.restaurants});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopThreeRatedRestaurants(widget.restaurants);
  }
  List<dynamic> topThreeRestaurants = [];
 void getTopThreeRatedRestaurants(List<dynamic> restaurants) {

   if (restaurants.isEmpty) {
     print('No restaurants available.');
     return;
   }

   restaurants.sort((a, b) => b['rating'].compareTo(a['rating']));

 setState(() {
   topThreeRestaurants = restaurants.take(3).toList();
 });


 }



  int _selectedIndex = 0;


  final List<IconData> icons = [
    Icons.format_align_center,
    Icons.brunch_dining_rounded,
    Icons.fastfood_rounded,
    Icons.emoji_food_beverage,
    Icons.rice_bowl,
    Icons.local_pizza_rounded,
  ];


  final List<String> texticon = [
    "all",
    "fine dine",
    "fast food",
    "cafeteria",
    "grills",
    "pizza",
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
     // backgroundColor: Colors.amber[50],
      backgroundColor: Colors.white,




      body: ListView(
        children: [


          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(27),
                bottomRight: Radius.circular(27),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.amber),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.region,
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          "Exact location of the user",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    if (Provider.of<userprovider>(context, listen: false).email == '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginscreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetStartedPage()),
                      );
                    }
                  },
                  icon: Icon(Icons.account_circle),
                  iconSize: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          SizedBox(height: 25,),

          CarouselSlider(
            items: [

              //1st Image of Slider
              Container(

                height: 200,
                width: 450,

                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(

                height: 200,
                width: 450,


                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[300],
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/delivery.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(


                height: 200,
                width: 450,



                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[300],
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(



                height: 200,
                width: 450,



                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[300],
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/4.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),



            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 250,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 4 / 3,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),






          SizedBox(height: 20,),

          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
              Text(
                'Categories',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  )


              ),
              SizedBox(width:3,),
              Text("view all",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                    ),
                  )

              ),

            ],),
          ),


          //categories
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the respective page based on index
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => All(region: widget.region)),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FineDining(region: widget.region)),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FastFood(region: widget.region,)),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Cafeteria(region: widget.region)),
                            );
                            break;
                          case 4:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GrillsPage(region: widget.region)),
                            );
                            break;
                          case 5:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pizza(region: widget.region)),
                            );
                            break;
                          default:
                            break;
                        }
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,///////////////////////////////////////////
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 0.0,
                            ),
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icons[index],
                                size: 37,
                                color: Colors.amber[200],/////////////////////////////////////

                              ),
                              SizedBox(height: 2),
                              Text(
                                texticon[index],
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),



          SizedBox(height: 30,),
          //featured restaurants

            Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
                'Top Rated Restaurants',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                )


            ),
          ),
            SizedBox(height: 15,),




            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),

              child: Row(
                children: [
                  // Container 1
                  Container(
                    width: 340,
                    height: 290,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(

                     // color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // img Container
                        Center(
                          child: Container(
                            width: 300,
                            height: 180,
                          //  margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(13),
                              image: DecorationImage(
                                image: NetworkImage(topThreeRestaurants[0]['ImageURL']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        // txt Container
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(topThreeRestaurants[0]['RestaurantName'],style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
                                  ),
                                )
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(topThreeRestaurants[0]['Description'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.grey,
                                    fontSize: 12,

                                            ),
                                         )
                                                                     ),
                                  ),
                                  SizedBox(width: 10,),

                                ],
                              ),


                              SizedBox(height: 10,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 47,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.lime[700],
                                    ),
                                    child: Center(
                                      child:
                                        Text(topThreeRestaurants[0]['rating'],  style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )),

                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Text('open 24/7',  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w300
                                    ),
                                  )),


                                ],


                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),






                  // Container 2
                  Container(
                    width: 340,
                    height: 290,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // img Container
                        Center(
                          child: Container(
                            width: 300,
                            height: 180,
                            //  margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(13),
                              image: DecorationImage(
                                image: NetworkImage(topThreeRestaurants[1]['ImageURL']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        // txt Container
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(topThreeRestaurants[1]['RestaurantName'],style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    SizedBox(width: 10,),
                                    Container(
                                      width: 250,
                                      child: Text(topThreeRestaurants[1]['Description'],
                                          overflow: TextOverflow.ellipsis,
                                         style: GoogleFonts.poppins(

                                        textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w300
                                        ),
                                      )
                                      ),
                                    ),
                                  ],
                                ),


                                SizedBox(height: 10,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 47,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lime[700],
                                      ),
                                      child: Center(
                                        child: Text(topThreeRestaurants[1]['rating'],  style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          ),
                                        )),
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Text('see more',  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w300
                                      ),
                                    )),


                                  ],


                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),

                  // Container 3
                  Container(
                    width: 340,
                    height: 290,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // img Container
                        Center(
                          child: Container(
                            width: 300,
                            height: 180,
                            //  margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(13),
                              image: DecorationImage(
                                image:NetworkImage(topThreeRestaurants[2]['ImageURL']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        // txt Container
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(topThreeRestaurants[2]['RestaurantName'],style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    SizedBox(width: 10,),
                                    Container(
                                      width: 250,
                                      child: Text(topThreeRestaurants[2]['Description'],

                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w300
                                        ),
                                      )
                                      ),
                                    ),
                                  ],
                                ),


                                SizedBox(height: 10,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 47,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lime[700],
                                      ),
                                      child: Center(
                                        child: Text(topThreeRestaurants[2]['rating'],  style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          ),
                                        )),
                                      ),
                                    ),
                                    SizedBox(width: 12,),



                                  ],


                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),

                  // Container 4
    /*
                  Container(
                    width: 340,
                    height: 290,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // img Container
                        Center(
                          child: Container(
                            width: 300,
                            height: 180,
                            //  margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(13),
                              image: DecorationImage(
                                image: AssetImage("assets/images/tinbox.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        // txt Container
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text("Restaurant Name",style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('pizza ', style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w300
                                      ),
                                    )
                                    ),


                                  ],
                                ),


                                SizedBox(height: 10,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 47,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lime[700],
                                      ),
                                      child: Center(
                                        child: Text('4.5',  style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          ),
                                        )),
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Text('50 min away from you',  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w300
                                      ),
                                    )),


                                  ],


                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  */
                ],

            )
            ),









        SizedBox(height: 20,),


          Container(
            margin: EdgeInsets.only(left: 18),
            child: Text('Quick Picks', style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,

            ),),

          ),
          SizedBox(height: 15,),
          RestaurantPicks( restaurants: widget.restaurants,),
          SizedBox(height: 80,),
















        ],







      ),


    );
  }
}
