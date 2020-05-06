import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicky/sign_up_page.dart';
import 'package:quicky/sign_up_page_rest.dart';
import 'package:quicky/team.dart';


import 'login_page.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomeState();
  }
}

class _WelcomeState extends State<Welcome>{
  void navigateToLogIn(){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }
  void TeamPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Team(), fullscreenDialog: true ));
  }
  void navigateToSignUp(){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUpPage()));
  }
  void navigateToSignUpRest(){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUpPageRest()));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Bienvenue sur Quicky'),

      ),
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
      Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Image.asset("assets/images/logo.jpg"),


    ), SizedBox(height: 30,),
            RaisedButton(
              onPressed: navigateToLogIn,
              child: Text('Connexion'),
            ),
            SizedBox(height: 10,),
            RaisedButton(
                onPressed: navigateToSignUp,
                child: Text('Pas encore inscrit? Cliquez ici !'),
            ),
            SizedBox(height: 30,),
            RaisedButton(
              onPressed: navigateToSignUpRest,
              child: Text('Vous êtes un restaurant? Cliquez ici !'),
            ),
            SizedBox(height: 30,),
            Text(" Quicker than ever! ", style: TextStyle(color: Colors.red[400], fontSize: 18),),
            SizedBox(height: 30,),
            FlatButton(
              onPressed: TeamPage,
            child:Text("  by HexaQuick ", style: TextStyle(color: Colors.white, fontSize: 15),),)]

      )
    ]
    )
    );
          /*

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          RaisedButton(
            onPressed: navigateToLogIn,
            child: Text('Connexion'),
          ),
          RaisedButton(
            onPressed: navigateToSignUp,
            child: Text('Inscription'),
          )
        ],
      ),

    )); */
  }
}
