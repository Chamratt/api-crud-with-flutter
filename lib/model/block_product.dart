import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shop_app/model/product.dart';

class BlockProduct with ChangeNotifier{
  List<Product>? _product;
  List<Product>? get productItem => _product;
  final String apiUrl = "http://192.168.138.242:80/api/products";
  set productItem(List<Product>? val){
    _product = val;
    notifyListeners();
  }
  Future<List<Product>?> getProduct() async {
    final res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      var mapResponse = jsonDecode(res.body);
      List items = mapResponse.cast<Map<String, dynamic>>();
      List<Product> dataAll = items.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();
      productItem = dataAll;
      return productItem;
    } else {
      throw Exception('Failed to load product') ;
    }
  }
  Future addItem(Product product) async {

    Map data = {
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'qty' : product.qty

    };

    final  response = await post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
      body: jsonEncode(data),

    );
    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }

  // Future<Product> getProductById(String id) async {
  //   final response = await http.get(Uri.parse('$apiUrl/$id'));
  //
  //   if (response.statusCode == 200) {
  //     return Product.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load a case');
  //   }
  // }
}Map<dynamic, dynamic> toJson(Product item) {
  var mapData = new Map();
  mapData["name"] = item.name;
  mapData["description"] = item.description;
  mapData["price"] = item.price;
  mapData["qty"] = item.qty;

  return mapData;
}