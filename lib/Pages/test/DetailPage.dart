import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {

  List list;
  int index;
  DetailPage({this.list , this.index});
  @override
  _DetailPageState createState() => _DetailPageState();
  int getIndex(){
    return this.index;
  }

}

class _DetailPageState extends State<DetailPage> {
  List data = [] ;
  DetailPage p = new DetailPage();

  Future<bool> getDetails(String name) async{
    String url="http://192.168.1.19/PHP/MyApp/getDetails.php";

    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
        body:{
          "lastname": name,
        }
    );
    setState(() {
      data = json.decode(res.body);
    });
    return true;
  }

  @override
  void initState(){
    this.getDetails(widget.list[widget.index]['lastname']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client : ${widget.list[widget.index]['lastname']}"),
      ),
      body: new ListView.builder(
        itemCount: data.length == null ? 0 : data.length ,
        itemBuilder: (context ,i){
          return
              new Container(
                height: 400,
                padding: new EdgeInsets.all(20),
                child: new Card(
                    child: Center(
                      child: new Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(padding: const EdgeInsets.only(top: 30),),
                          Image.network(
                            'https://www.institut-ciel.com/wp-content/uploads/2018/07/details.png',
                            width: 100,
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 30),),
                          new Text(widget.list[widget.index]['lastname'] , style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold , color: Colors.lightBlue) ,),
                          new Text( " First name : ${widget.list[widget.index]['firstname']}" , style: new TextStyle(fontSize: 18.0 ,fontWeight: FontWeight.bold ) ),
                          new Text( " E-mail : ${widget.list[widget.index]['email']}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                          new Text( " Marque Vehicule : ${data[i]['marque']}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                          new Text( " Categorie Vehicule : ${this.data[i]['categorie']}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                          new Text( " Année Vehicule : ${this.data[i]['annee']}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                          new Padding(padding: const EdgeInsets.only(top: 30),),
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Checked.svg/1024px-Checked.svg.png',
                            width: 60,
                          ),
                        ],
                      ),
                    ),

                ),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        },
      ),
    );
  }
}

