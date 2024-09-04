import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_doan/product.dart';

import '../update_product_screen.dart';

class ItemWidget extends StatefulWidget {
  List<Product> products;

  ItemWidget({super.key, required this.products});

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget>{

  Future<void> deleteProduct(Product product, BuildContext context) async{
    final docProduct = FirebaseFirestore.instance.collection('Products').doc(product.id);
    await docProduct.delete().then((result){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Xoá sản phẩm thành công")));
    }).catchError((onError){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Xoá sản phẩm thất bại. Error!')));
    });
  }
  Future<void> displayDialogDeleteProduct(BuildContext context, int position){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Confirm to delete'),
            content: const Text('Are you sure to delete this item ?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')
              ),
              TextButton(
                  onPressed: (){
                    deleteProduct(widget.products[position], context);
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')
              )
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context){
    return GridView.count(
      childAspectRatio: 0.58,
      physics: NeverScrollableScrollPhysics(), //Scroll ListView
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < widget.products.length ; i++)
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children:[
              InkWell(
                onTap: (){
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.network(
                    widget.products[i].image,
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Container(
                padding:const EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child:Text(
                widget.products[i].name,
                  style: const TextStyle(
                      fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(widget.products[i].description,
                style: const TextStyle(
                    fontSize: 15, color: Colors.blueGrey
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${widget.products[i].price} VND',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton.filledTonal(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UpdateProductScreen(product: widget.products[i],)));
                      },
                      iconSize: 30,
                      color: Colors.blueGrey,
                      hoverColor: Colors.greenAccent,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    const SizedBox(width: 5,),
                    IconButton.filledTonal(
                      onPressed: () {
                        displayDialogDeleteProduct(context, i);
                      },
                      iconSize: 30,
                      color: Colors.blueGrey,
                      hoverColor: Colors.redAccent,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}