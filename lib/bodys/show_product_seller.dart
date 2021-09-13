import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingmall/models/product_model.dart';
import 'package:shoppingmall/ultility/my_constant.dart';
import 'package:shoppingmall/widgets/show_prograess.dart';
import 'package:shoppingmall/widgets/show_title.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  bool load = true;
  bool? haveData;
  List<ProductModel> productModels = [];

  @override
  void initState() {
    super.initState();
    loadValueFormAPI();
  }

  Future<Null> loadValueFormAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;

    String apiGetProductWhereIdSeller =
        '${MyConstant.domain}/shoppingmall/getProductWhereidSeller.php?isAdd=true&idSeller=$id';
    await Dio().get(apiGetProductWhereIdSeller).then((value) {
      print('value ==> $value');

      if (value.toString() == 'null') {
        // nodata
        setState(() {
          load = false;
          haveData = true;
        });
      } else {
        // have data
        for (var item in json.decode(value.data)) {
          ProductModel model = ProductModel.fromMap(item);
          print('value ==>> ${model.name}');

          setState(() {
            load = false;
            haveData = true;
            productModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : haveData!
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                          title: 'No Product',
                          textStyle: MyConstant().h1Style()),
                      ShowTitle(
                          title: 'Plase Add Product',
                          textStyle: MyConstant().h2Style()),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct),
        child: Text('Add'),
      ),
    );
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (context, index) => Card(
          child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth*0.5-5,
                    child: ShowTitle(title: productModels[index].name, textStyle: MyConstant().h2Style()),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth*0.5-5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowTitle(title: 'Price ${productModels[index].price} BTH', textStyle: MyConstant().h2Style()),
                        ShowTitle(title: 'productModels[index].detail' , textStyle: MyConstant().h3Style()),
                      ],
                    ),
                  ),
                ],
              ),
        ));
  }
}
