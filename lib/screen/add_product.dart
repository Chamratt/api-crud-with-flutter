import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/block_product.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/services/api.dart';
class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productQtyController = TextEditingController();
  ImagePicker? imagePicker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<BlockProduct>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
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
                  controller: _productQtyController,
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
                // InkWell(
                //   child: Container(
                //     width: 300,
                //     height: 200,
                //     margin: EdgeInsets.all(15),
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Center(
                //       child: Container(
                //         child: _image != null ? Image.file(
                //           _image!,
                //
                //         ):Icon(
                //           Icons.add_photo_alternate,
                //           size: 35.0,
                //         )
                //       ),
                //     ),
                //   ),
                //   onTap: () {
                //     _showPicker(context);
                //   },
                // ),
                //
                // SizedBox(height: 20,),
                Center(
                   child:  Container(
                     width: 250,
                     height: 50,
                     child: ElevatedButton(
                         onPressed: () async {
                           if(_formKey.currentState!.validate()){
                             _formKey.currentState!.save();
                             await  productProvider.addItem(Product(
                               name: _productNameController.text,
                               description: _productDescriptionController.text,
                               price: _productPriceController.text,
                               qty: _productQtyController.text
                             ));
                             apiService.getProduct();
                           }

                            Navigator.pop(context);


                           // show();
                           clear();
                         },
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),),
                          child: Text('Add')),
                   )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> addProduct() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

    }
  }
  void clear(){
  _productNameController.clear();
  _productPriceController.clear();
  _productDescriptionController.clear();
  }
  void _imgFromCamera()async{
    XFile? image = await imagePicker!.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }
  void _imgFromGallery()async{
    XFile? image = await imagePicker!.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void show(){
    final snackBar = SnackBar(
      content: const Text('Add Success'),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
