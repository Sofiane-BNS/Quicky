import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicky/login_page.dart';
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

  Future<DocumentSnapshot> getProfile() async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    return Firestore.instance
        .collection('Profile')
        .document(uid)
        .get();
  }
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart(panier: panier,resetPanier: resetPanier(),)));
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[

            FutureBuilder(
              future: getProfile(),
              builder: (context, snapshot) {
                return new UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data.data['nom'] + " " + snapshot.data.data['prenom']),
                  accountEmail: Text('joel@gmail.com'),
                  currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.orange,
                      child:Icon(Icons.person, color:Colors.white),
                    ),
                  ),
                decoration: new BoxDecoration(
                  color:Colors.orange
                ),

              ),
             ListTile(
               title:Text('Home'),
             leading:Icon(Icons.home),
             ),
              InkWell(
                onTap:(){} ,
                child: ListTile(
                  title:Text('Mon compte'),
                  leading:Icon(Icons.person),
                ),
              ),
              InkWell(
                onTap:(){} ,
                child: ListTile(
                  title:Text('Parametres'),
                  leading:Icon(Icons.settings),
                ),
              ),
              InkWell(
                onTap:(){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginPage()), (Route<dynamic> route) => false);} ,

                child: ListTile(
                  title:Text('Deconnexion'),
                  leading:Icon(Icons.exit_to_app),

              ),
            )
          ],
        ),
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