import 'package:auto_center/Pages/vehicule/fichevehicule.dart';
import 'package:auto_center/helper/DBHelper.dart';
import 'package:auto_center/helper/intervention.dart';
import 'package:better_uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ajoutintervention extends StatefulWidget {

  String name,immatriculation,code,codevehicule;
  ajoutintervention({this.immatriculation , this.code,this.name,this.codevehicule});

  @override
  _ajoutinterventionState createState() => _ajoutinterventionState();
}

class _ajoutinterventionState extends State<ajoutintervention> {

  TextEditingController controllerdate = new TextEditingController();
  TextEditingController controllerdescription = new TextEditingController();
  TextEditingController controllermt = new TextEditingController();

  var idinterv = Uuid.v1(); // Uuid object

  addDataWithSQF() async {
    intervention c = new intervention(controllerdate.text, controllerdescription.text, controllermt.text, "Ouvert", widget.code,widget.codevehicule ,idinterv.time.toString());
    int res = await DBHelper().insertInterv(c);

  }
  addInterv() async {
    String url="http://192.168.1.19/PHP/MyApp/addintervention.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
        body:{
          "codevehicule" : widget.codevehicule,
          "code" : widget.code,
          "immatriculation" : widget.immatriculation,
          "date" : controllerdate.text,
          "description": controllerdescription.text ,
          "mt" : controllermt.text,
        }
    );
    var resbody = json.decode(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD Intervention : ${widget.name}"),
      ),
      body: Form(
        autovalidate: true,
        child: ListView(
          padding:EdgeInsets.all(20.0),
          children: <Widget>[
            Text('Info Intervention'),
            TextFormField(
              controller: controllerdescription ,
              decoration: new InputDecoration(
                  icon: Icon(FontAwesomeIcons.info  , color: Colors.blueAccent),
                  hintText: "Dectiption ",
                  border: InputBorder.none,
                  labelText: "Dectiption"
              ),
            ),
            TextFormField(
              controller: controllerdate ,
              decoration: new InputDecoration(
                  icon: Icon(FontAwesomeIcons.info  , color: Colors.blueAccent),
                  hintText: "Date ",
                  border: InputBorder.none,
                  labelText: "Date"
              ),
            ), TextFormField(
              controller: controllermt ,
              decoration: new InputDecoration(
                  icon: Icon(FontAwesomeIcons.info  , color: Colors.blueAccent),
                  hintText: "Montant ",
                  border: InputBorder.none,
                  labelText: "Montant"
              )
            ),
            SizedBox(height: 20,),
            RaisedButton(
              color: Colors.deepPurple,
              child:new Text("Ajouter",style: TextStyle(color: Colors.white),),
              onPressed: () {
                addDataWithSQF();
                _showDialog();
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => fichevehicule(name: widget.name,immatriculation: widget.immatriculation,code: widget.code,)));

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
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success !!"),
          content: new Text("Intervention Ajouter :D"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
