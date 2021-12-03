import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/block_product.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/screen/add_product.dart';
import 'package:shop_app/screen/product_list.dart';
import 'package:shop_app/services/api.dart';

import 'detail_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  late Future <List<Product>> productList;
  late Future<Product> _product;
  String? id = '';
  BlockProduct? product;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      productList = apiService.getProduct();
    });
  }
   void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final notifier = Provider.of<BlockProduct>(context);
    if(this.product != notifier){
      this.product = notifier;
      Future.microtask(() => notifier.getProduct());
    }
  }
  @override
  Widget build(BuildContext context) {
     BlockProduct blockProduct = Provider.of<BlockProduct>(context);

    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToAddScreen(context);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Test With Api'),

        ),
        body: blockProduct.productItem == null ? Center(
          child: CircularProgressIndicator(),
        ):ProductList()
      ),
    );
  }
  navigateToAddScreen (BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProduct()),
    );
  }
  Future<void> refresh(){
    setState(() {
      product!.getProduct();
    });
     return Future.delayed(Duration(seconds: 2));

  }
  }

