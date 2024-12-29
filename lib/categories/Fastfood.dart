import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import '../home/FavoritesProvider.dart';
import '../details/RestaurantDetailPage.dart';
class FastFood extends StatefulWidget {
  @override
  final String region ;
  FastFood({ required this.region});
  State<FastFood> createState() => _FastFoodState();
}

class _FastFoodState extends State<FastFood> {
  List restaurants=[];
  List originalRestaurants=[];
  String category='FastFood';
  void initState() {
    super.initState();
    fetchRestaurants(widget.region);
  }

  Future<void> fetchRestaurants(String region) async {

    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getRestaurants.php?region=$region&category=$category"));

    if (response.statusCode == 200) {


     setState(() {
       restaurants= jsonDecode(response.body);
       originalRestaurants = jsonDecode(response.body);
     });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(


          child: Column(

            children: [
              // SizedBox(height: 17,),
              Container(

                decoration:    BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),


                child: Stack(
                  children: [
                    // Image container
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 150,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/fastfoodheader.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Text container
                    Positioned(
                      left: 20,
                      bottom: 40,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                                "Fast Food",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                )
                            ),
                            Text('in your city',  style: GoogleFonts.poppins(
                              //fontWeight: FontWeight.w00,
                              //fontSize: 30,
                            )
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 34,
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /////////////////////////////////////////// filter//////////////////////////////////////////////////////////////////////////
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[50],
                      foregroundColor: Colors.black,
                      elevation: 2,
                    ),
                    child: PopupMenuButton<int>(
                      onSelected: (value) {

                        if (value ==1) {
                          restaurants =originalRestaurants;
                          setState(() {
                            restaurants= restaurants.where((restaurant) {

                              return restaurant['priceRange'] == 1;
                            }).toList();
                          });

                        } else if (value ==2) {
                          restaurants =originalRestaurants;
                          setState(() {

                            restaurants= restaurants.where((restaurant) {
                              return restaurant['priceRange'] == 2;
                            }).toList();
                          });

                        } if( value==3){
                          restaurants =originalRestaurants;
                          setState(() {

                            restaurants= restaurants.where((restaurant) {
                              return restaurant['priceRange'] == 3;
                            }).toList();
                          });

                        }else{
                          setState(() {
                            restaurants=originalRestaurants;
                          });

                        };
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Text('All'),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text('Expensive'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text('Affordable'),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Text('Economical'),
                        ),
                      ],
                      child: Row(
                        children: [
                          Text('Filter' ),
                          Icon(Icons.arrow_drop_down),

                        ],
                      ),
                    ),
                  ),


                  // Sort
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[50],
                      foregroundColor: Colors.black,
                      elevation: 2,
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {

                        if (value == 'name') {
                          setState(() {
                            restaurants.sort((a, b) => a['RestaurantName'].compareTo(b['RestaurantName']));
                          });
                        } else if (value == 'ratings') {
                          setState(() {
                            restaurants.sort((a, b) => b['rating'].compareTo(a['rating']));
                          });


                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'name',
                          child: Text('By Name'),
                        ),
                        PopupMenuItem(
                          value: 'ratings',
                          child: Text('By Ratings'),
                        ),
                      ],
                      child: Row(
                        children: [
                          Text('Sort' ),
                          Icon(Icons.arrow_drop_down),

                        ],
                      ),
                    ),
                  ),

                ],
              ),





              SizedBox(height: 30,),



              ListView.builder(

                // Disable scrolling in this ListView since parent already scrolls
                physics: NeverScrollableScrollPhysics(),
                // Make ListView take minimum space needed
                shrinkWrap: true,
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
             //     final isFavorite = context.watch<FavoritesProvider>().favoriteIndices.contains(index);

                  return GestureDetector(
                  onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>RestaurantDetailPage(RestaurantID: restaurant['RestaurantID'])),
                  );
                  },
                    child: Column(
                      children: [







                        Container(
                          margin:  EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                    // Image container
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(


                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(restaurant['ImageURL']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                    // Text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          restaurant['RestaurantName'],
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500

                                          )
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                          restaurant["Description"],
                                          style: GoogleFonts.poppins(

                                          )
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 20,),
                                          SizedBox(width: 5,),
                                          Text(restaurant["rating"]?? '0.0'),
                                          SizedBox(width: 15,),
                                          Container(
                                            height: 27,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.amber[50],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  restaurant['CategoryName'],
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,

                                                  )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),



                              ],
                            ),
                          ),

                        ),

                      ],


                    ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}
