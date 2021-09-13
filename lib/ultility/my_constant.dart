import 'package:flutter/material.dart';

class MyConstant {
  // Genernal 
  static String appName = 'Miragez Project';
  static String domain = 'https://ecb4-49-228-164-184.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/creatAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSalerService = '/salerService';
  static String routeRiderService = '/riderService';
  static String routeAddProduct = '/addProduct';

  //image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';
  static String avatar = 'images/avatar.png';
  static String renka = 'images/renka.jpg';

  //Color
  static Color primary = Color(0xff01579b);
  static Color dark = Color(0xff4f83cc);
  static Color light = Color(0xff002f6c);
  
  // style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );    

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
              primary: MyConstant.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            );
}