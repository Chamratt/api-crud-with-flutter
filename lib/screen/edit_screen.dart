import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/screen/homepage.dart';
import 'package:shop_app/services/api.dart';
class EditScreen extends StatefulWidget {
  const EditScreen(this.product);
  final Product product;
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productQuantityController = TextEditingController();
  int? id;
  @override
  void initState() {
    // TODO: implement initState
    _productNameController.text = widget.product.name!;
    _productDescriptionController.text = widget.product.description!;
    _productPriceController.text = widget.product.price! ;
    _productQuantityController.text = widget.product.qty!.toString();
    id = widget.product.id!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.name}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: _productNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Input Product Name',
                    filled: true,

                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _productPriceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Input Product Price',
                    filled: true,

                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: _productDescriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Input Product Description',
                    filled: true,

                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: _productQuantityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product quantity';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Input Product Quantity',
                    filled: true,

                  ),
                ),
                SizedBox(height: 20,),
                Center(
                    child:  Container(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {

                              upDateProduct();
                              setState(() {
                                apiService.getProduct();
                              });

                            // show();
                          Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),),
                          child: Text('Update')),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void clear(){
    _productNameController.clear();
    _productPriceController.clear();
    _productDescriptionController.clear();
    _productQuantityController.clear();
  }
  void upDateProduct(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      apiService.updateProduct(id!,Product(name: _productNameController.text,price: _productPriceController.text,description: _productDescriptionController.text,qty: _productQuantityController.text)
      );
    }
  }
}
