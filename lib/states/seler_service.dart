import 'package:flutter/material.dart';
import 'package:shoppingmall/bodys/shop_manage_seller.dart';
import 'package:shoppingmall/bodys/show_order_seller.dart';
import 'package:shoppingmall/bodys/show_product_seller.dart';
import 'package:shoppingmall/ultility/my_constant.dart';
import 'package:shoppingmall/widgets/show_signout.dart';
import 'package:shoppingmall/widgets/show_title.dart';

class SelerService extends StatefulWidget {
  const SelerService({Key? key}) : super(key: key);

  @override
  _SelerServiceState createState() => _SelerServiceState();
}

class _SelerServiceState extends State<SelerService> {
  
  List<Widget> widgets = [ShowOrderSeller(), ShopManageSeller(),ShowProductSeller()];
  int indexwidget = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowOrder(),
                menuShopMannage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
        
      ),body: widgets[indexwidget],
    );
  }

  ListTile menuShowOrder() {
    return ListTile(onTap: (){
      setState(() {
        indexwidget = 0;
        Navigator.pop(context);
      });
    },
      leading: Icon(Icons.filter_1_outlined),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของ Order ที่สั่ง',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShopMannage() {
    return ListTile(onTap: (){
      setState(() {
        indexwidget = 1;
        Navigator.pop(context);
      });
    },
      leading: Icon(Icons.filter_2_outlined),
      title: ShowTitle(
        title: 'Shop Manage',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของหน้าร้าน ที่ให้ลูกค้าเห็น',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(onTap: (){
      setState(() {
        indexwidget = 2;
        Navigator.pop(context);
      });
    },
      leading: Icon(Icons.filter_3_outlined),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของสินค้าที่เราขาย',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }



}
