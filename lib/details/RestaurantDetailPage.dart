import 'dart:convert';
import 'package:damproject/constants/text.dart';
import 'package:provider/provider.dart';
import '../user/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../home/HomePage.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailPage extends StatefulWidget {
  final int RestaurantID;
  const RestaurantDetailPage({required this.RestaurantID});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {

  final TextEditingController commentController = TextEditingController();
  double _userRating = 0;
  List menu=[];
  final ScrollController _scrollController = ScrollController();
  Map<String , dynamic> restaurant = {
    'RestaurantID': 'Loading...',
    'RestaurantName': 'Loading...',
    'Phone': 'Loading...',
    'Description': 'Loading...',
    'ImageURL': 'Loading...',
    'RegionName': 'Loading...',
    'CategoryName': 'Loading...',
    'OpeningTime': 'Loading...',
    'ClosingTime': 'Loading...',
    'Location': 'Loading...',
    'PriceRange': 'Loading...',
    'Liked': 'Loading...',
  };
     @override
  void initState() {
    super.initState();
    getrestaurant(widget.RestaurantID);
    getmenu(widget.RestaurantID);
    getcomment(widget.RestaurantID);
  }
   bool like = false ;
  Future<void> getrestaurant (int RestaurantID) async{
    String email = Provider.of<userprovider>(context, listen: false).email;
    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getRestaurantDetails.php?RestaurantID=$RestaurantID&email=$email"));
    if (response.statusCode == 200) {
      setState(() {
        restaurant = jsonDecode(response.body)[0];
        print(restaurant);
        like = int.tryParse(restaurant['liked'].toString()) == 1;
      });
      }else {
              print('Request failed with status: ${response.statusCode}');
    }
     }
  Future<void> getmenu (int RestaurantID) async{

    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getmenu.php?RestaurantID=$RestaurantID"));
    if (response.statusCode == 200) {
      setState(() {
        menu = jsonDecode(response.body);
        print(menu);
      });
    }else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
  Future<void> getcomment (int RestaurantID) async{

    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getcomment.php?RestaurantID=$RestaurantID"));
    if (response.statusCode == 200) {
      setState(() {
        comments = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        print(comments);
      });
    }else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print('URL launched successfully: $url');
      } else {
        print('Cannot launch URL: $url');
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      throw e;
    }
  }//////////////////didnt work ill again when i find time sorry guys/////////////////////
  void addcomment(BuildContext context, String restaurantID, TextEditingController commentController, double _userRating) async {
    print(commentController.text);
    String userEmail = Provider.of<userprovider>(context, listen: false).email;




        Map<String, String> requestData = {
          'email': userEmail,
          'restaurantid': restaurantID,

          'comment': commentController.text,
          'review': _userRating.toString(),
        };

        var response = await http.post(
          Uri.parse('http://192.168.56.1/damproject/addcomment.php'),
          body: requestData,
        );

        if (response.statusCode == 200) {

             setState(() {
               commentController.clear();
               _userRating = 0;
               getcomment(widget.RestaurantID);

             });



    }
  }
  Future<void> toggleLikeRestaurant({ required int restaurantId, required bool isLiked, }) async {


    String email = Provider.of<userprovider>(context, listen: false).email;
    final url = Uri.parse("http://192.168.56.1/damproject/togglelike.php?email=$email&RestaurantID=$restaurantId&liked=${isLiked ? '1' : '0'}");

    try {

      final response = await http.post( url  );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          print("Successfully updated like status.");

        } else {
          print("Failed to update like status: ${responseBody['error']}");
        }
      } else {
        print("Server error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

   List<Widget> menuItems = [];
   List<Map<String, dynamic>> comments = [
    {
      'username': 'Sarah K.',
      'Review': 5.0,
      'CommentText': 'Amazing food and atmosphere! The crepes were delicious.',
      'CommentDate': '2 days ago'
    },
     {
       'username': 'Sarah K.',
       'Review': 5.0,
       'CommentText': 'Amazing food and atmosphere! The crepes were delicious.',
       'CommentDate': '2 days ago'
     },


  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [

                Stack(
                  clipBehavior: Clip.none,
                  children: [

                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Image.network(
                        restaurant['ImageURL'] ??'https://media-cdn.tripadvisor.com/media/photo-s/',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Top Buttons
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.lime[800]),
                                onPressed: () { },

                              ),
                            ),
                            Row(
                              children: [

                                if(Provider.of<userprovider>(context).email!='')

                                CircleAvatar(
                                  backgroundColor: Colors.white,

                                  child: IconButton(

                                    icon: Icon(  like ? Icons.favorite :Icons.favorite_border , color: Colors.lime[800]),
                                    onPressed: () {
                                       toggleLikeRestaurant(

                                        restaurantId: widget.RestaurantID,
                                        isLiked: like,
                                      );
                                      setState(() {
                                        like= !like ;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: Icon(Icons.share, color: Colors.lime[800]),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Restaurant Info Card
                    Positioned(
                      bottom: -80,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant['RestaurantName']?? 'loading...',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber[200]),
                                Text( restaurant['ratings']?? '',
                                    style: GoogleFonts.poppins()),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildQuickInfoItem(Icons.access_time, 'Open Now'),
                                InkWell(
                                  onTap: () async {
                                    try {
                                      await _launchURL(restaurant['Location']);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Could not open location: $e')),
                                      );
                                    }
                                  },
                                  child: _buildQuickInfoItem(Icons.location_on, 'Go to'),
                                ),


                                _buildQuickInfoItem(Icons.motorcycle, '15-20 min'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 100),
                // Rest of the content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoSection(),
                      const SizedBox(height: 24),
                      _buildMenuSection(),
                      const SizedBox(height: 24),
                      _buildReviewsSection(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildCommentInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.lime[800]),
        const SizedBox(height: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Information',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lime[800],
            )),
        const SizedBox(height: 8),
        _buildInfoItem(Icons.phone, restaurant['Phone']?? 'loading'),
        _buildInfoItem(Icons.location_on, 'loading'),
        _buildInfoItem(Icons.access_time, 'Opening time:'+restaurant['OpeningTime']),
        _buildInfoItem(Icons.watch_later, 'Closing time:'+restaurant['ClosingTime']),
            _buildInfoItem(Icons.info_outline, restaurant['Description']??'Loading'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.lime[800]),
          const SizedBox(width: 8),
          Expanded(
              child: Text(text, style: GoogleFonts.poppins(),
                maxLines: 3, )

          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Menu',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lime[800],
            )),
        const SizedBox(height: 16),

        Container(
          height: 400,
          child: ListView(
            children: menu.map((menuitem) {
              return _buildMenuItem(
                menuitem['Item']??'loading',
                menuitem['Price']??'loading',
                menuitem['Description']??'loading',
              );
            }).toList(),
          ),
        )


      ],
    );
  }

  Widget _buildMenuItem(String name, String price, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              Text(price,
                  style: GoogleFonts.poppins(color: Colors.lime[800])),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: GoogleFonts.poppins()),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lime[800],
            )),
        const SizedBox(height: 16),
        ...comments.map((comment) => _buildReviewItem(comment)).toList(),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(comment['username']??'loading...',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              Text(comment['CommentDate']??'loading....', style: GoogleFonts.poppins()),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
                  (index) {
                int reviewValue = int.tryParse(comment['Review'].toString()) ?? 0;
                return Icon(
                  index < reviewValue ? Icons.star : Icons.star_border,
                  color: Colors.amber[600],
                  size: 20,
                );
              },
            ),
          ),

          const SizedBox(height: 8),
          Text(comment['CommentText']??'loading....', style: GoogleFonts.poppins()),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {


    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Provider.of<userprovider>(context).email != '')
            Row(
              children: List.generate(
                5,
                    (index) => IconButton(
                  icon: Icon(
                    index < _userRating ? Icons.star : Icons.star_border,
                    color: Colors.amber[200],
                  ),
                  onPressed: () {
                    setState(() {
                      _userRating = index + 1.0;
                    });
                  },
                ),
              ),
            ),
          if (Provider.of<userprovider>(context).email != '')
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a review...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.lime,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send_rounded, color: Colors.lime[800]),
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      print(commentController.text);
                      setState(() {
                        addcomment(context ,restaurant['RestaurantID'] ,commentController ,_userRating );
                      });
                    }
                  },
                ),
              ],
            ),
          if (Provider.of<userprovider>(context).email == '')
            Text(
              'Login to add a comment',
              style: TextStyle(color: Colors.black45),
            ),
        ],
      ),
    );
  }

}