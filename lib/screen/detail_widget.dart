import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/screen/edit_screen.dart';
import 'package:shop_app/services/api.dart';
class DetailWidget extends StatefulWidget {
  DetailWidget(this.product);
  final Product product;



  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {

  final ApiService apiService = ApiService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditScreen(widget.product)));
          }, icon: Icon(Icons.edit)),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Product Name: '),
                  SizedBox(width: 20,),
                  Text('${widget.product.name}')
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('Product Price: '),
                  SizedBox(width: 20,),
                  Text('${widget.product.price}')
                ],
              ),
              SizedBox(height: 20,),
              Row(

                children: [
                  Text('Product Description: '),
                  SizedBox(width: 20,),
                  Text('${widget.product.description}')
                ],
              ),
              SizedBox(height: 20,),
              // Image.network('${widget.product.image}')
            ],
          ),
        ),
      ),
    );
  }

}
