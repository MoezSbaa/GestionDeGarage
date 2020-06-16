import 'package:auto_center/helper/DBHelper.dart';
import 'package:auto_center/helper/vehicule.dart';
import 'package:better_uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'listvehicule.dart';
class ajoutvehicule extends StatefulWidget {
  String code;
  List list;
  int index;
  String name;
  ajoutvehicule({this.name,this.code ,this.index , this.list});

  @override
  _ajoutvehiculeState createState() => _ajoutvehiculeState();
}

TextEditingController controllerimmatriculation = new TextEditingController();
TextEditingController controllermarque = new TextEditingController();
TextEditingController controllercategorie = new TextEditingController();
TextEditingController controllerannee = new TextEditingController();
var codev = Uuid.v1(); // Uuid object

addDataWithSQF(String code) async {
  vehicule v = new vehicule(controllerimmatriculation.text, controllermarque.text , controllercategorie.text, controllerannee.text,code ,codev.time.toString() );
  int res = await DBHelper().insertVehicule(v);
  controllerimmatriculation.text = "";
  controllermarque.text="";
  controllercategorie.text="";
  controllerannee.text="";
}

addData(String name , String code) async {
  String url="http://192.168.1.19/PHP/MyApp/addvehicule.php";
  var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
      body:{
        "clientname" : name,
        "code" : code,
        "immatriculation" : controllerimmatriculation.text,
        "marque": controllermarque.text ,
        "categorie" : controllercategorie.text,
        "annee" : controllerannee.text,
      }
  );
  var resbody = json.decode(res.body);
  print(resbody);
}


class _ajoutvehiculeState extends State<ajoutvehicule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD vehicule : ${widget.name}"),
      ),
      body:
         Form(
          autovalidate: true,
          child: ListView(
            padding:EdgeInsets.all(20.0),
            children: <Widget>[
              Text('Info New Vehicule'),
              TextFormField(
                controller: controllerimmatriculation ,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.car  , color: Colors.blueAccent),
                    hintText: "Enter your Immatriculation :",
                    border: InputBorder.none,
                    labelText: "Immatriculation"
                ),
              ),
              TextFormField(
                controller: controllermarque ,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.car  , color: Colors.blueAccent),
                    hintText: "Enter your car marque :",
                    border: InputBorder.none,
                    labelText: "Car marque"
                ),
              ),
              TextFormField(
                controller: controllercategorie ,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.car  , color: Colors.blueAccent),
                    hintText: "Enter your car Categorie :",
                    border: InputBorder.none,
                    labelText: "Car Categorie"
                ),
              ), TextFormField(
                controller: controllerannee ,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.car  , color: Colors.blueAccent),
                    hintText: "Enter your car Year :",
                    border: InputBorder.none,
                    labelText: "Car Year"
                ),
              ),     SizedBox(height: 20,),
              RaisedButton(
                color: Colors.deepPurple,
                child:new Text("Ajouter Vehicule",style: TextStyle(color: Colors.white),),
                onPressed: () {
                  //addData(widget.name , widget.code);
                  addDataWithSQF(widget.code);
//                  showDialog(
//                    context: context,
//                    builder: (BuildContext context) {
//                      // return object of type Dialog
//                      return AlertDialog(
//                        title: new Text("Operation Terminer"),
//                        content: new Text("Votre information a été ajouter avec succès"),
//                        actions: <Widget>[
//                          // usually buttons at the bottom of the dialog
//                          new FlatButton(
//                            child: new Text("OK"),
//                            onPressed: () {
//                              Navigator.of(context).pop();
//                            },
//                          ),
//                        ],
//                      );
//                    },
//                  );
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => listvehicule(list: widget.list,index: widget.index,code : widget.code ,)));
                },
                textColor: Colors.black,
                elevation: 15,
                padding: const EdgeInsets.all(15.0),
              )

            ],
          ),
        ),

    );
  }
}
