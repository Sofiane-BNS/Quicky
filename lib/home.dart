import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicky/model/panier.dart';
import 'cart.dart';
import 'details_menu.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  PanierModel panier = PanierModel();

  resetPanier(){
    panier = PanierModel();
  }

  @override
  Widget build(BuildContext context) {
    print(panier.listItemMenu.length);
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart(panier: panier,resetPanier: resetPanier(),)));
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
                itemBuilder: (context, index) => _buildList(context, snapshot.data.documents[index], panier),

              );
            }
          },
        ),

      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot documentSnapshot, PanierModel panier) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => new DetailsMenuPage(categorieId: documentSnapshot.documentID,panier: panier,)));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.network( documentSnapshot['imageUrl'],
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text(documentSnapshot['nomTypeProduit'], style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold ),),

            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.orange,
            size: 24.0,
          ),

        ],
      ),
    ),
  );
}