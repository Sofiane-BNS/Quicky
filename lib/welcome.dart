import 'package:flutter/material.dart';
import 'package:quicky/sign_up_page.dart';

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

  void navigateToSignUp(){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUpPage()));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue sur Quicky'),

      ),
      body: Column(
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
    );
  }
}
