import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_doan/LoginPage.dart';
import 'package:ltddnc_doan/auth.dart';
import 'package:ltddnc_doan/create_product_screen.dart';
import 'package:ltddnc_doan/product.dart';

import 'widget/HomeAppBar.dart';
import 'widget/ItemWidget.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String? errorMessage = '';

  Future<void> signOut() async{
    try{
      await Auth().signOut();
    } on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Stream<List<Product>> readProduct() => FirebaseFirestore.instance
      .collection('Products')
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList()
  );

  @override
  Widget build( BuildContext context ){
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                //Search Widget
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Tìm kiếm thứ bạn muốn...",
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.search,
                        size: 27,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CreateProductScreen()));
                    },
                    icon: const Icon(Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: const Text('Thêm',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(const EdgeInsets.fromLTRB(15, 5, 15, 5)),
                    ),
                  ),
                ),
                //Item
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: const Text("Danh sách sản phẩm",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                  ),
                ),
                StreamBuilder(
                    stream: readProduct(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        final products = snapshot.data!;
                        return ItemWidget(products: products);
                      } else if(snapshot.hasError){
                        return Text('Something went wrong!${snapshot.error}');
                      } else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    }
                ),              //Item Widget
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index){},
        height: 60,
        color: Colors.blueGrey,
        items: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "Homepage");
            },
            child: Icon(Icons.home, size: 30, color: Colors.white),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "cartPage");
            },
            child: Icon(CupertinoIcons.settings, size: 30, color: Colors.white),
          ),
          InkWell(
            onTap: (){
              signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              });
            },
            child: Icon(Icons.logout, size: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}