import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:damproject/user/userprovider.dart';
import 'package:provider/provider.dart';

class Favorites {

  Future<void> toggleLike( int restaurantId, bool liked , BuildContext context) async {
    final email=Provider.of<userprovider>(context, listen: false).email ;
    final response = await http.post(
      Uri.parse('http://192.168.56.1/damproject/togglelike.php'),
      body: {
        'email': email,
        'RestaurantID': restaurantId.toString(),
        'liked': liked ? '1' : '0',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle like');
    }
  }
}
