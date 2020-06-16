import 'dart:convert';

import 'package:auto_center/helper/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ajoutavance.dart';
class listavance extends StatefulWidget {
  String immat , name ,code , codevehicule ;
  listavance({this.immat , this.name ,this.code , this.codevehicule});
  @override
  _listavanceState createState() => _listavanceState();
}

class _listavanceState extends State<listavance> {
  List datainterv = [] , res1 = [];
  List data = [] , res = [];

  Future<bool> getAvanceswithsqf() async {
    print("hani fel getavaces with sqf");
    res1 = await DBHelper().getAvances(widget.code , widget.codevehicule);
    setState(() {
      datainterv = res1 ;
    });
    return true;
  }
  Future<bool> getAvances(String codevehicule , String code) async{
    String url="http://192.168.1.19/PHP/MyApp/getAvances.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
        body:{
          "codevehicule" : codevehicule,
          "code" : code
        }
    );
    setState(() {
      datainterv = json.decode(res.body);
    });
    return true;
  }

  Future<bool> getlistvehiculewithsqf() async {
    res = await DBHelper().getVehicules(widget.code , widget.immat);
    setState(() {
      data = res;
    });
    return true;
  }

  Future<bool> getlistvehicule(String name , String code , String immat) async{
    String url="http://192.168.1.19/PHP/MyApp/getvehicule.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
        body:{
          "lastname": name,
          "immatriculation": immat,
          "code" : code
        }
    );
    setState(() {
      data = json.decode(res.body);
    });
    return true;
  }

  @override
  void initState(){
    this.getAvanceswithsqf();
    this.getlistvehiculewithsqf();
    super.initState();
  }
  SingleChildScrollView databody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("Date",style: TextStyle(color: Colors.deepPurple),),
                numeric: false,
                tooltip: "Date avance"
            ),
            DataColumn(
                label: Text("Montant" ,style: TextStyle(color: Colors.deepPurple) ),
                numeric: false,
                tooltip: "Montant"
            ), DataColumn(
                label: Text("Desc" ,style: TextStyle(color: Colors.deepPurple)),
                numeric: false,
                tooltip: "Description"
            ),

          ],
          rows: datainterv.map(
                (di) => DataRow(
                cells: [
                  DataCell(
                    Text(di.DATEE_AVANCES),
//                  onTap: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => ficheintervention(name: widget.name,immatriculation: widget.immatriculation,code:widget.code ,codevehicule: widget.codevehicule,)));
//                  },
                  ),
                  DataCell(
                    Text(di.MONTANT_AVANCES),
                  ),
                  DataCell(
                    Text(di.DESCRIPTION_AVANCES),
                  )
                ]),
          ).toList(),
        ),
      ),
    );
  }
  Future _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    getAvanceswithsqf();
    databody();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Avances"),
        ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: new ListView.builder(
          itemCount:  data.length == null ? 0 : data.length ,
          itemBuilder: (context ,i){
            return
              new Container(
                height: 600,
                padding: new EdgeInsets.all(5),
                child: new Card(
                  child: Center(
                    child: new Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(top: 5),),
                        Image.asset(
                          'Images/car.png',
                          width: 120,
                        ),
                        new Text(widget.name , style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold , color: Colors.lightBlue) ,),
                        new Text( " Immatriculation : ${data[i].IMMAT_Vehicule}" , style: new TextStyle(fontSize: 18.0 ,fontWeight: FontWeight.bold ) ),
                        new Text( " marque Vehicule : ${data[i].MARQUE}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                        new Text( " Categorie Vehicule : ${data[i].CATEGORIE}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                        new Text( " Année Vehicule : ${this.data[i].ANNEE}" , style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ) ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            Center(
                              child: databody(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );

          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ajoutavance(code: widget.code,codevehicule: widget.codevehicule)));
        },
      ) ,
    );
  }
}

