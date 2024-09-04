import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(children: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, "Homepage"); // Back to HomePage
          },
          child: Icon(Icons.arrow_back, color: Colors.blueGrey, size: 30),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Cart',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Spacer(),
        Icon(Icons.more_vert,
          size: 30,
          color: Colors.blueGrey,
        ),
      ],
      ),
    );
  }
}