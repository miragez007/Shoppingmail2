import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingmall/bodys/edit_product.dart';
import 'package:shoppingmall/models/product_model.dart';
import 'package:shoppingmall/ultility/my_constant.dart';
import 'package:shoppingmall/widgets/show_image.dart';
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
    if (productModels.length != 0) {
      productModels.clear();
    } else {}

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
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct)
                .then((value) => loadValueFormAPI()),
        child: Text('Add'),
      ),
    );
  }

  String createUrl(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> strings = result.split(',');
    String url = '${MyConstant.domain}/shoppingmall${strings[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (context, index) => Card(
              child: Row(
                children: [
                  Container(
                    //picture
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth * 0.5 - 5,
                    height: constraints.maxWidth * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ShowTitle(
                            title: productModels[index].name,
                            textStyle: MyConstant().h2Style()),
                        Container(
                          width: constraints.maxWidth * 0.5,
                          height: constraints.maxWidth * 0.4,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: createUrl(productModels[index].images),
                            placeholder: (context, url) => ShowProgress(),
                            errorWidget: (context, url, error) =>
                                ShowImage(path: MyConstant.image1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth * 0.5 - 5,
                    height: constraints.maxWidth * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowTitle(
                            title: 'Price ${productModels[index].price} BTH',
                            textStyle: MyConstant().h2Style()),
                        ShowTitle(
                            title: '${productModels[index].detail}',
                            textStyle: MyConstant().h3Style()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                print('## you Click Edit ');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProduct(productModel: productModels[index],),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit_outlined,
                                size: 36,
                                color: MyConstant.dark,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                print(
                                    '## you Click Delete form index = $index');
                                confirmDialogDele(productModels[index]);
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                size: 36,
                                color: MyConstant.dark,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Future<Null> confirmDialogDele(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: CachedNetworkImage(
            imageUrl: createUrl(productModel.images),
            placeholder: (context, url) => ShowProgress(),
          ),
          title: ShowTitle(
            title: 'Delete ${productModel.name} ?',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: productModel.detail,
            textStyle: MyConstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              print('## confirm dellet at id == ${productModel.id}');
              String apiDeleteProductWhereId =
                  '${MyConstant.domain}/shoppingmall/deleteProductWhereId.php?isAdd=true&id=${productModel.id}';
              await Dio().get(apiDeleteProductWhereId).then((value) {
                Navigator.pop(context);
                loadValueFormAPI();
              });
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
