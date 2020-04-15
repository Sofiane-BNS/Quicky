import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quicky/home.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void signUp() async{

    if(formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.trim(), password: _password);
        FirebaseUser user = authResult.user;
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Home()), (Route<dynamic> route) => false);
      } catch (e){
        print(e);
      }

    }
  }

  void moveToLogIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value.isEmpty ? "Entrez un email" : null,
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  validator: (value) => value.isEmpty ? "Entrez un mot de passe" : null,
                  onSaved: (value) => _password = value,
                ),
                RaisedButton(
                  child: Text('Inscription', style: TextStyle(fontSize: 20),),
                  onPressed: signUp,
                ),
                FlatButton(onPressed: moveToLogIn,
                  child: Text('Connexion', style: TextStyle(fontSize: 20.0)),
                )
              ],
            )
        ),
      ),
    );
  }
}
