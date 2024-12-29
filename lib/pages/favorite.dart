import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../home/FavoritesProvider.dart';
import '../user/userprovider.dart';
import '../details/RestaurantDetailPage.dart';

class Favorite extends StatefulWidget {

  @override
  State<Favorite> createState() => _FavoriteState();
}
class _FavoriteState extends State<Favorite> {
  List restaurants=[];
  @override

  void initState() {
    super.initState();
    getfavorites();
  }
  Future<void> getfavorites() async {
        String email= Provider.of<userprovider>(context, listen: false).email;
    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/favorite.php?email=$email"));
    if (response.statusCode == 200) {
      setState(() {
        restaurants= jsonDecode(response.body);
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
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
                          // image: DecorationImage(image: AssetImage("assets/images/grillsheader.png"), fit: BoxFit.cover,),
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
                                "Favorite Restaurants",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                )
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];

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
                                      image: NetworkImage(restaurant['ImageURL']),
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
                                          restaurant['Description'],
                                          style: GoogleFonts.poppins(

                                          )
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 20,),
                                          SizedBox(width: 5,),
                                          Text(restaurant['rating'] ?? '0.0'),
                                          SizedBox(width: 15,),

                                          Row(
                                            children: List.generate(
                                              restaurant['priceRange'],
                                                  (index) => Icon(
                                                Icons.attach_money,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15,),
                                          Container(
                                            height: 27,
                                            width: 100,
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
                                          SizedBox(width: 15,),
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
