import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'FavoritesProvider.dart';

class RestaurantPicks extends StatefulWidget {
  final List restaurants;
  const RestaurantPicks({required this.restaurants});

  @override
  State<RestaurantPicks> createState() => _RestaurantPicksState();
}

class _RestaurantPicksState extends State<RestaurantPicks> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Disable scrolling in this ListView since parent already scrolls
      physics: NeverScrollableScrollPhysics(),
      // Make ListView take minimum space needed
      shrinkWrap: true,
      itemCount:3,
      itemBuilder: (context, index) {
        final restaurant = widget.restaurants[index];
    //    final isFavorite = context.watch<FavoritesProvider>().favoriteIndices.contains(index);
        return Container(
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
                      image: NetworkImage(restaurant["ImageURL"]),
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
                        restaurant["RestaurantName"],
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
                          Text(restaurant["rating"] ?? '0.0'),
                          SizedBox(width: 15,),
                          Container(
                            height: 27,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                restaurant["CategoryName"],
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
        );
      },
    );
  }
}