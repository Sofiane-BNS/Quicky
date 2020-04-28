import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/item_menu.dart';
import 'model/panier.dart';

class Cart extends StatefulWidget {
  PanierModel panier;
  Function resetPanier;

  Cart({this.panier, this.resetPanier});


  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Panier'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              widget.resetPanier;
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.panier.listItemMenu.length,
          itemBuilder: (context, index){
            return ItemMenuListItem(itemMenu: widget.panier.listItemMenu[index]);
          },
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text("Total:"),
              subtitle: Text(widget.panier.getPrix() + "€"),
            )),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  "Terminé",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.orange,
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ItemMenuListItem extends StatelessWidget {
  final ItemMenu itemMenu;
  ItemMenuListItem({this.itemMenu});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection("Restaurants").document("cJraGzuF74OHyrTfykeg").collection("Menu").document(itemMenu.idCategorie).collection("Produits").document(itemMenu.id).get(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return Text('Loading');
        } else {
          return ListTile(
            title: Text(snapshot.data["nomProduit"]),
            subtitle: Text('prix unitaire: ' + itemMenu.prix.toString() + "€"),
            trailing: Text(itemMenu.number.toString()),
          );
        }
      },
    );
  }
}
