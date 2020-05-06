import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicky/liste_menu.dart';


class FormRestaurant extends StatefulWidget {
  final String idRestaurant;
  FormRestaurant(idRestaurant):this.idRestaurant = idRestaurant;

  @override
  _FormRestaurantState createState() => _FormRestaurantState();
}

class _FormRestaurantState extends State<FormRestaurant> {

  String _adresse,_nomRestaurant;
  double _latitude,_longitude;
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations du restaurant'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: Firestore.instance.collection("Restaurants").document(widget.idRestaurant).snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData){
              return Text('Loading..');
            } else {
              return _buildList(context, snapshot.data);
            }
          },
        ),
      ),
    );
  }


  Widget _buildList(BuildContext context, DocumentSnapshot documentSnapshot) {

    return GestureDetector(
      child: Form(
        key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'adresse'),
                validator: (value) => value.isEmpty ? "Entrez une adresse" : null,
                onSaved: (value) => _adresse = value,
                initialValue: documentSnapshot["adresse"],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'latitude'),
                validator: (value) {
                  if(value.isEmpty) return "Entrez une latitude";
                  if(double.tryParse(value)==null) return "Entrez une latitude valide";
                  return null;
                },
                onSaved: (value) => _latitude = double.parse(value),
                initialValue: documentSnapshot["location"].latitude.toString(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'longitude'),
                validator: (value) {
                  if(value.isEmpty) return "Entrez une longitude";
                  if(double.tryParse(value)==null) return "Entrez une longitude valide";
                  return null;
                },
                onSaved: (value) => _longitude = double.parse(value),
                initialValue: documentSnapshot["location"].longitude.toString(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'nom du restaurant'),
                validator: (value) => value.isEmpty ? "Entrez un nom de restaurant" : null,
                onSaved: (value) => _nomRestaurant = value,
                initialValue: documentSnapshot["nomRestaurant"],
              ),
              RaisedButton(
                child: Text('soumettre', style: TextStyle(fontSize: 20),),
                onPressed: _updateData,
              ),
              FlatButton(
                child: Text('Modifier votre menu', style: TextStyle(fontSize: 16),),
                onPressed: navigateToFormMenu,
              ),
            ],
          )
      ),
    );

  }

  _updateData() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
    }
    await Firestore.instance.collection("Restaurants").document(widget.idRestaurant).updateData({
      'adresse': _adresse,
      'location' : new GeoPoint(_latitude, _longitude),
      'nomRestaurant': _nomRestaurant,
    });
  }

  void navigateToFormMenu(){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => FormMenu(widget.idRestaurant), fullscreenDialog: true));
  }

}
