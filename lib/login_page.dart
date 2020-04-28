import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quicky/sign_up_page.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void signIn() async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.trim(), password: _password);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Home()), (Route<dynamic> route) => false);
      } catch (e){
        print(e);
      }

    }
  }

  void moveToRegister(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
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
                    child: Text('Connexion', style: TextStyle(fontSize: 20),),
                    onPressed: signIn,
                ),
                FlatButton(onPressed: moveToRegister,
                    child: Text('Créez un compte', style: TextStyle(fontSize: 20.0)),
                )
              ],
            )
        ),
      ),
    );
  }
}