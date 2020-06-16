import 'dart:convert';
import 'package:auto_center/helper/DBHelper.dart';
import 'package:auto_center/helper/avances.dart';
import 'package:better_uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ajoutavance extends StatefulWidget {
  String code , codevehicule ;
  ajoutavance({this.code , this.codevehicule});
  @override
  _ajoutavanceState createState() => _ajoutavanceState();
}

class _ajoutavanceState extends State<ajoutavance> {

  TextEditingController controllerdate = new TextEditingController();
  TextEditingController controllerdescription = new TextEditingController();
  TextEditingController controllermt = new TextEditingController();
  var idavan = Uuid.v1(); // Uuid object

  addAvanceswithsqf() async {
    String codeintervsqf = await DBHelper().getcodeInterv(widget.code , widget.codevehicule);
    avances c = new avances(controllerdate.text, controllermt.text, controllerdescription.text, codeintervsqf.toString() , widget.codevehicule );
    int res = await DBHelper().insertAvances(c);

  }
  addAvances() async {
    String url="http://192.168.1.19/PHP/MyApp/addAvances.php";
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
        title: Text("Ajout Avances "),
      ),
      body: Form(
        autovalidate: true,
        child: ListView(
          padding:EdgeInsets.all(20.0),
          children: <Widget>[
            Text('Info Avances'),
        TextFormField(
          controller: controllerdate ,
          decoration: new InputDecoration(
              icon: Icon(FontAwesomeIcons.info  , color: Colors.blueAccent),
              hintText: "Date ",
              border: InputBorder.none,
              labelText: "Date"
          ),
         ),
            TextFormField(
                controller: controllermt ,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.info  , color: Colors.blueAccent),
                    hintText: "Montant ",
                    border: InputBorder.none,
                    labelText: "Montant"
                )
            ),TextFormField(
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
                addAvanceswithsqf();
                _showDialog();
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => fichevehicule(name: widget.name,immatriculation: widget.immatriculation,code: widget.code,)));

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
          content: new Text("Avance Ajouter :D"),
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
