import 'package:flutter/material.dart';
import 'package:quicky/generate_QRcode.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'commandes_historique.dart';

class Restaurant extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RestaurantState();
  }
}

class _RestaurantState extends State<Restaurant>{
  String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez un restaurant'),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.photo_camera,
              color: Colors.white,
            ),
            onPressed: () {
              scanQr(context);
            },
          ),

          new IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GeneratorQR()));
            },
          )
          ,new IconButton(
            icon: Icon(
              Icons.credit_card,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new HistoriquePage()));
            },
          )
        ],
      ),
      body: Container(

      ),
    );
  }

  Future scanQr(context) async {
    try {
      String barcode = await BarcodeScanner.scan();
      print("扫描结果是： $barcode");
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => new Home(barcode)));
        return this.barcode = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          return this.barcode = 'permission denied';
        });
      } else {
        setState(() {
          return this.barcode = '$e';
        });
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}