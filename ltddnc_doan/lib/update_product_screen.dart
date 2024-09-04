import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_doan/product.dart';

import 'Homepage.dart';

class UpdateProductScreen extends StatefulWidget{
  Product product;
  UpdateProductScreen({super.key, required this.product});

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formField = GlobalKey<FormState>();

  TextEditingController _controllerId = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();

  @override
  void initState(){
    super.initState();
    _controllerId = TextEditingController(text: widget.product.id);
    _controllerName = TextEditingController(text: widget.product.name);
    _controllerPrice = TextEditingController(text: '${widget.product.price}');
    _controllerDescription = TextEditingController(text: widget.product.description);
    _controllerImage = TextEditingController(text: widget.product.image);
  }

  Future updateProduct(Product product, BuildContext context) async{
    final docProduct = FirebaseFirestore.instance.collection('Products').doc(widget.product.id);
    final json = product.toJson();
    await docProduct.update(json).then((result){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Cập nhật sản phẩm thành công")));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    }).catchError((onError){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cập nhật sản phẩm thất bại. Error!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            ' Cập nhật sản phẩm',
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body:
        Form(
          key: _formField,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                readOnly: true,
                controller: _controllerId,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 6, color: Colors.blueGrey,
                        )
                    ),
                    labelText: 'Id',
                    hintText: 'Nhập Id sản phẩm'
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Vui lòng nhập Id";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _controllerName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 6, color: Colors.blueGrey,
                        )
                    ),
                    labelText: 'Tên sản phẩm',
                    hintText: 'Nhập tên sản phẩm'
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Vui lòng nhập tên sản phẩm";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _controllerPrice,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 6, color: Colors.blueGrey,
                        )
                    ),
                    labelText: 'Giá sản phẩm',
                    hintText: 'Nhập giá sản phẩm'
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Vui lòng nhập giá sản phẩm";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20,),
              TextFormField(

                controller: _controllerDescription,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 6, color: Colors.blueGrey,
                        )
                    ),
                    labelText: 'Mô tả sản phẩm',
                    hintText: 'Nhập mô tả sản phẩm'
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Vui lòng nhập mô tả sản phẩm";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _controllerImage,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 6, color: Colors.blueGrey,
                        )
                    ),
                    labelText: 'Đường dẫn hình ảnh',
                    hintText: 'Nhập đường dẫn hình ảnh sản phẩm'
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Vui lòng nhập đường dẫn hình ảnh sản phẩm";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  if (_formField.currentState!.validate()){
                    final product = Product(
                      id: _controllerId.text,
                      name: _controllerName.text,
                      price: int.parse(_controllerPrice.text),
                      description: _controllerDescription.text,
                      image: _controllerImage.text,
                    );
                    updateProduct(product, context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                ),
                child: const Text(
                  'Cập nhật sản phẩm',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}