import 'package:auto_center/Pages/cout/ficheintervention.dart';
import 'package:auto_center/Pages/intervention/ajoutintervention.dart';
import 'package:auto_center/Pages/vehicule/welcome.dart';
import 'package:auto_center/helper/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class fichevehicule extends StatefulWidget {

  String name,immatriculation,code,codevehicule;
  fichevehicule({this.name , this.immatriculation,this.code,this.codevehicule });

  @override
  _fichevehiculeState createState() => _fichevehiculeState();
}

class _fichevehiculeState extends State<fichevehicule> {

  List data = [] , res =[];
  List data2 = [] , res1 =[];
  List<Interv> interv = [];

  Future<bool> getlistvehiculewithsqf() async {
    res = await DBHelper().getVehicules(widget.code , widget.immatriculation);
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


//  Future<bool> getInterventions(String codevehicule) async{
//    String url="http://192.168.1.13/PHP/MyApp/getInterventions.php";
//    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
//        body:{
//          "codevehicule" : codevehicule
//        }
//    );
//    setState(() {
//      data2 = json.decode(res.body);
//    });
//    return true;
//  }
  Future<bool> getInterventionswithsqf(String codevehicule) async{
    res1 = await DBHelper().getInterv(codevehicule);

    setState(() {
      data2 = res1;
    });
    return true;
  }
     Future<bool> getInterventions(String codevehicule) async{
       String url="http://192.168.1.19/PHP/MyApp/getintervention.php";
        var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
          body:{
              "codevehicule" : codevehicule
          }
        );
        setState(() {
          data2 = json.decode(res.body);
        });
        return true;
     }


//    Future<List<Interv>> getInterventions(String codevehicule) async{
//  String url="http://192.168.1.13/PHP/MyApp/getInterventions.php";
//    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
//      body:{
//  "codevehicule" : codevehicule
//      }
//    );
//    var  resbody = json.decode(res.body);
//    data = json.decode(res.body);
//    for (var i in resbody){
//      Interv j = Interv(i["idinterventions"], i["idvehicule"], i["idclient"], i["datee"],i["descriptionn"],i["montant"],i["etat"]);
//      interv.add(j);
//    }
//    return interv;
//  }
  @override
  void initState(){
    getInterventionswithsqf(widget.codevehicule);
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
              tooltip: "Date Interv"
            ),
            DataColumn(
                label: Text("Desc" ,style: TextStyle(color: Colors.deepPurple)),
                numeric: false,
                tooltip: "Description"
            ),
            DataColumn(
                label: Text("Montant" ,style: TextStyle(color: Colors.deepPurple) ),
                numeric: false,
                tooltip: "Montant"
            ),DataColumn(
                label: Text("Etat" ,style: TextStyle(color: Colors.deepPurple)),
                numeric: false,
                tooltip: "Etat"
            ),

          ],
          rows: data2.map(
              (user) => DataRow(
                cells: [
                  DataCell(
                    Text(user.DATEE),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ficheintervention(name: widget.name,immatriculation: widget.immatriculation,code:widget.code ,codevehicule: widget.codevehicule,)));
                },
                  ),
                  DataCell(
                    Text(user.DESCRIPTION),
                  ),
                  DataCell(
                    Text(user.MONTANT),
                  ),
                  DataCell(
                    Text(user.ETAT),
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
    getlistvehiculewithsqf();
    getInterventionswithsqf(widget.codevehicule);
    databody();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Fiche Vehicule"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: new ListView.builder(
          itemCount: data.length == null ? 0 : data.length ,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ajoutintervention(name: widget.name,immatriculation: widget.immatriculation,code: widget.code, codevehicule: widget.codevehicule,))); // with back
        },
      ),
    );
  }
}
class Interv{
  final String idinterventions,idvehicule,idclient ,datee,descriptionn,montant,etat;
  Interv(this.idinterventions,this.idvehicule,this.idclient,this.datee , this.descriptionn , this.montant , this.etat);
}
