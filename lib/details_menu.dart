import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsMenuPage extends StatefulWidget{

  String menuId;

  DetailsMenuPage({this.menuId});

  @override
  State<StatefulWidget> createState() {
    return _DetailsMenuPageState();
  }
}

class _DetailsMenuPageState extends State<DetailsMenuPage>{
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
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => new DetailsMenuPage(menuId: documentSnapshot.documentID)));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(documentSnapshot['nomProduit'], style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold ),),
              subtitle: Text(documentSnapshot['prix'].toString(), style: TextStyle(color: Colors.orange),),
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward,
            color: Colors.orange,
            size: 24.0,
          ),

        ],
      ),
    ),
  );
}