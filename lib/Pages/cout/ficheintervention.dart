import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'listavance.dart';
import 'listdepense.dart';

class ficheintervention extends StatefulWidget {
  String name, immatriculation, code, codevehicule;

  ficheintervention(
      {this.name, this.immatriculation, this.code, this.codevehicule});

  @override
  _ficheinterventionState createState() => _ficheinterventionState();
}

class _ficheinterventionState extends State<ficheintervention> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Center(
              child: new Text("Intervention : ${widget.name}",
                  textAlign: TextAlign.center)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Center(
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => listdepense(immat : widget.immatriculation,name : widget.name,code: widget.code,codevehicule: widget.codevehicule)));
                  },
                  textColor: Colors.black,
                  color: Colors.white,
                  elevation: 0.0,
                  shape: Border.all(width: 2.0, color: Colors.black),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Text(
                    "Depenses",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => listavance(immat : widget.immatriculation,name : widget.name,code: widget.code,codevehicule: widget.codevehicule)));
                  },
                  textColor: Colors.black,
                  color: Colors.white,
                  elevation: 0.0,
                  shape: Border.all(width: 2.0, color: Colors.black),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Text(
                    "Avances",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
