import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/block_product.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/screen/detail_widget.dart';
class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlockProduct blockProduct = Provider.of<BlockProduct>(context);
    List<Product> selectProduct(){
      List<Product> selectedList;
      selectedList = blockProduct.productItem!;
      return selectedList;
    }
    List<Product>selectedList = selectProduct();

    return ListView.builder(
      itemCount: blockProduct.productItem == null ? 0 :selectedList.length,
      itemBuilder: (BuildContext context,int index){
        return Card(
          child: InkWell(
            child: ListTile(
              leading: Icon(Icons.shop_2),
              title: Text('${selectedList[index].name}'),
              subtitle: Row(children: [
                Text('\$${selectedList[index].price}',style: TextStyle(color: Colors.redAccent),),
                SizedBox(width: 20,),
                Text('Quantity: ${selectedList[index].qty}',style: TextStyle(color: Colors.redAccent))
              ],),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){

                },
              ),

            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(selectedList[index]),));
            },
          ),
        );
      },
    );
  }
}
