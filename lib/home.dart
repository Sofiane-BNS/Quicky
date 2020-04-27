import 'package:flutter/material.dart';
import 'package:quicky/login_page.dart';

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
        title: Text('Accueil'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          new IconButton(icon:Icon(Icons.shopping_cart, color:Colors.white) , onPressed: (){})
        ],
      ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[

              new UserAccountsDrawerHeader(
                  accountName: Text('Joël Boni'),
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
    );
  }
}