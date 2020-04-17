import 'package:flutter/material.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Acceuil'),
      actions: <Widget>[
        new IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
          },
        )
      ],
    ));
  }
}
