import 'dart:convert';

import 'package:auto_center/helper/DBHelper.dart';
import 'package:auto_center/helper/depenses.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'listdepense.dart';
class ajoutdepense extends StatefulWidget {
  String code , codevehicule ;
  ajoutdepense({this.code , this.codevehicule});
  @override
  _ajoutdepenseState createState() => _ajoutdepenseState();
}

class _ajoutdepenseState extends State<ajoutdepense> {

  TextEditingController controllerdate = new TextEditingController();
  TextEditingController controllerdescription = new TextEditingController();
  TextEditingController controllermt = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  addDepenseswithsqf() async {
    String codeintervsqf = await DBHelper().getcodeInterv(widget.code , widget.codevehicule);
    depenses c = new depenses(controllerdate.text, controllermt.text, controllerdescription.text, codeintervsqf.toString() , widget.codevehicule );
    int res = await DBHelper().insertDepenses(c);

  }
  addDepense() async {
    String url="http://192.168.1.19/PHP/MyApp/adddepenses.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
        body:{
          "codevehicule" : widget.codevehicule,
          "code" : widget.code,
          "descriptionn": controllerdescription.text ,
          "datee": controllerdate.text ,
          "montant": controllermt.text ,
        }
    );
    var resbody = json.decode(res.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout Depense "),
      ),
      body: Form(
        autovalidate: true,
        child: ListView(
          padding:EdgeInsets.all(20.0),
          children: <Widget>[
            Text('Info Intervention'),
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
            TextFormField(
                controller: controllerdescription ,
                decoration: new InputDecoration(
                  icon: Icon(FontAwesomeIcons.info  , color: Colors.blueAccent),
                  hintText: "Description ",
                  border: InputBorder.none,
                  labelText: "Description"
                ),
          ),
            SizedBox(height: 20,),
            RaisedButton(
              color: Colors.deepPurple,
              child:new Text("Ajouter",style: TextStyle(color: Colors.white),),
              onPressed: () {
                addDepenseswithsqf();
                _showDialog();
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => fichevehicule(name: widget.name,immatriculation: widget.immatriculation,code: widget.code,)));
//                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => listdepense(code: widget.code,codevehicule: widget.codevehicule,)));

              },
              textColor: Colors.white,
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
          content: new Text("depense Ajouter :D"),
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

