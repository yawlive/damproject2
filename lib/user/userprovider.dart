import 'package:flutter/material.dart';

class userprovider extends ChangeNotifier{
  String username="" ;
  String email="" ;
  String image="" ;
  String location="";



  void setemail(newemail){
    email=newemail;
    notifyListeners();
  }
  void setusername(newusername){
    username=newusername;
    notifyListeners();
  }
  void setimage(newimage){
    image=newimage;
    notifyListeners();
  }

  void setlocation(newlocation){
    location = newlocation;
    notifyListeners();
  }
  void logout(){
        username='' ;
        email='' ;
        image='' ;
        location='';
       notifyListeners();
     }
}