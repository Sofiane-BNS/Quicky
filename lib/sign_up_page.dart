import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'restaurant.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _nom;
  String _prenom;

  void signUp() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try{
        AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.trim(), password: _password);
        await Firestore.instance.collection("Profile").document(authResult.user.uid).setData({
          'email': _email,
          'nom' : "gadach",
          'prenom' : "amine"
        });
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //Home()), (Route<dynamic> route) => false);
            Restaurant()), (Route<dynamic> route) => false);
      } catch (e) {
        print(e);
      }

    }
  }

  void moveToLogIn() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Inscription'),
        )
        ,
        body: Column(
            children: <Widget>[
              SizedBox(height: 5,),
              Text('Rejoins la QuickTeam!', style: TextStyle(color: Colors.black, fontSize: 22),)
              ,SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Image.asset("assets/images/ff.jpg"),
              ),
              SizedBox(height: 10,),
              Text('Veuillez remplir les informations suivantes',
                style: TextStyle(color: Colors.black, fontSize: 17),),

              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      TextFormField(
                        style: TextStyle(color: Colors.black,
                      ),
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) =>
                        value.isEmpty
                            ? "Entrez un email"
                            : null,
                        onSaved: (value) => _email = value,
                      ),
                      Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                            style: TextStyle(color: Colors.black,),
                            decoration: InputDecoration(labelText: 'Mot de passe'),
                            obscureText: true,
                            validator: (value) =>
                            value.isEmpty
                                ? "Entrez un mot de passe"
                                : null,
                            onSaved: (value) => _password = value,
                          ),
                            Expanded(
                            child: Column(
                              children: <Widget>[
                             RaisedButton(
                             child: Text(
                              'Inscription', style: TextStyle(fontSize: 15.0),),
                              onPressed: signUp,
                            ),
                             RaisedButton(onPressed: moveToLogIn,
                             child: Text(
                            'Connexion', style: TextStyle(fontSize: 15.0)),
                      )
                      ]
                            )
                            )
                    ],
                  )
              )
         ]
      )
    )
    ]
    )
    );
  }
}

/*} Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("assets/images/rb.jpg",),
          )
        ),
        padding: EdgeInsets.all(16),
        child: Stack(),
        :Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
  }*/

