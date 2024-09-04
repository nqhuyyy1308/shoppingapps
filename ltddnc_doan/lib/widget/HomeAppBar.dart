import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: const Row(
        children: [
        Icon(
          Icons.sort,
          size: 30,
          color: Colors.blueGrey,
        ),
          Padding(padding: EdgeInsets.only(left: 20,
          ),
            child: Text(
              "Product Management",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}