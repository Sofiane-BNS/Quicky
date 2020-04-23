import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicky/model/item_menu.dart';
import 'package:quicky/model/panier.dart';

class DetailsMenuPage extends StatefulWidget{

  String menuId;
  PanierModel panier;
  DetailsMenuPage({this.menuId, this.panier});

  @override
  State<StatefulWidget> createState() {
    return _DetailsMenuPageState();
  }
}

class _DetailsMenuPageState extends State<DetailsMenuPage>{


  PanierModel panier;

  @override
  void initState() {
    panier = widget.panier;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faîtes votre choix'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("Restaurants").document("cJraGzuF74OHyrTfykeg").collection("Menu").document(widget.menuId).collection("Produits").snapshots(),
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

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Text(documentSnapshot['nomProduit'], style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold ),),
            subtitle: Text('prix: ' + documentSnapshot['prix'].toString() + "€", style: TextStyle(color: Colors.orange),),
          ),
        ),
        Spacer(),
        Text('0', style: TextStyle(color: Colors.black)),
        IconButton(
          onPressed: (){
            panier.listItemMenu.add(ItemMenu.name('aaaa', 1));
          },
          icon: Icon(
            Icons.add,
            color: Colors.orange,
            size: 24.0,
          ),
        ),

      ],
    ),
  );
}