import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/block_product.dart';
import 'package:shop_app/screen/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BlockProduct())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'API',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage(),
      ),
    );
  }
}

