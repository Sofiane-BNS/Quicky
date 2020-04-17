import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faîtes votre commande'),
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
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("Restaurants").document("cJraGzuF74OHyrTfykeg").collection("Menu").snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData){
              return Text('Loading..');
            } else {
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => _buildList(context, snapshot.data.documents[index]),

              );
            }
          },
        ),

      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot documentSnapshot) {
  return ListTile(
    title: Text(documentSnapshot['nomProduit']),
    subtitle: Text(documentSnapshot['prix'].toString()),
  );
}