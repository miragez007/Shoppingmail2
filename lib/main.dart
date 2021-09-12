import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingmall/states/add_product.dart';
import 'package:shoppingmall/states/authen.dart';
import 'package:shoppingmall/states/buyer_service.dart';
import 'package:shoppingmall/states/create_account.dart';
import 'package:shoppingmall/states/rider_service.dart';
import 'package:shoppingmall/states/seler_service.dart';
import 'package:shoppingmall/ultility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen' : (BuildContext context)=>Authen(),
  '/creatAccount':(BuildContext context)=> CreateAccoun(),
  '/buyerService': (BuildContext context)=> BuyerService(),
  '/salerService':(BuildContext context)=> SelerService(),
  '/riderService':(BuildContext context)=> RiderService(),
  '/addProduct' :(BuildContext context)=> AddProduct(),
};

String? initlalRoute;


// สร้าง future เลือกหน้า 
Future<Null> main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('#type ===>> $type');
  if (type?.isEmpty ?? true)  {
    initlalRoute = MyConstant.routeAuthen; 
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
      initlalRoute = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
      initlalRoute = MyConstant.routeSalerService;
        runApp(MyApp());
        break;
      case 'rider':
      initlalRoute = MyConstant.routeRiderService;
        runApp(MyApp());
        break;
      default:
    }

  }

}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}