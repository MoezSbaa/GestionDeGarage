import 'package:auto_center/Pages/vehicule/ajoutvehicule.dart';
import 'package:auto_center/helper/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'fichevehicule.dart';

class listvehicule extends StatefulWidget {
  String code;
  List list;
  int index;
  listvehicule({this.list , this.index , this.code});

  @override
  _listvehiculeState createState() => _listvehiculeState();

}

class _listvehiculeState extends State<listvehicule> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  List data = [] , data2 = [] ;

//  Future<bool> getlistvehicule(String name , String code) async{
//    String url="http://192.168.1.13/PHP/MyApp/getvehiculelist.php";
//    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
//        body:{
//          "lastname": name,
//          "code" : code
//        }
//    );
//    setState(() {
//      data = json.decode(res.body);
//    });
//    return true;
//  }


  Future<List<vehiculedata2>> _getvehiculewithsqf(String code) async{
    List resbody2=[];
    resbody2 = await DBHelper().getCodeVehicule(code);
    setState(() {
      data2 = resbody2 ;
    });
    List<vehiculedata2> vehicules = [];

    for (var i in resbody2){
      vehiculedata2 vehicule = vehiculedata2(i["idvehicule"],i["immatriculation"], i["marque"], i["categorie"], i["annee"] ,i["code"],i["codevehicule"]);
      vehicules.add(vehicule);
    }
    return vehicules;
  }

  Future<List<vehiculedata>> _getvehicule(String name , String code) async{
    List resbody=[];
    String url="http://192.168.1.19/PHP/MyApp/getvehiculelist.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
    body: {
        "lastname": name,
        "code" : code
        }
    );
    setState(() {
      resbody = json.decode(res.body);
      data = json.decode(res.body);

    });
    List<vehiculedata> vehicules = [];

      for (var i in resbody){
        vehiculedata vehicule = vehiculedata(i["idvehicule"],i["idclient"],i["immatriculation"], i["marque"], i["categorie"], i["annee"] ,i["code"],i["codevehicule"]);
        vehicules.add(vehicule);
      }
      return vehicules;
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Vehicule : ${widget.list[widget.index].LAST_NAME} "),
      ),
        body: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: _getvehiculewithsqf( widget.code),
                  builder: (BuildContext context  , AsyncSnapshot snapshot){
                    if ( data2.length == 0){
                      return Container(
                        child: Center(
                          child: Text("Aucun Vehicule Trouver Pour le moment", style: TextStyle(color: Colors.red),),
                        ),
                      );
                    }else{
                      return ListView.builder(
                        itemCount: data2.length,
                        itemBuilder: (BuildContext context , int index){
                          var immatriculation = data2[index].IMMAT_Vehicule;
                          var categorie = data2[index].CATEGORIE;
                          var codevehicule = data2[index].CODE_VEHICULE;

//                          var immatriculation = snapshot.data[index].immatriculation;
//                          var categorie = snapshot.data[index].categorie;

                          return GestureDetector(
                            child: ListTile(
                              title: Text(immatriculation),
                              subtitle: Text(categorie),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => fichevehicule(name : widget.list[widget.index].LAST_NAME , immatriculation : immatriculation , code : widget.code , codevehicule : codevehicule)));
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),

        floatingActionButton: FloatingActionButton(
           child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (BuildContext context)=>new ajoutvehicule( name: widget.list[widget.index].LAST_NAME , code : widget.code , index : widget.index , list : widget.list))
            );
            },
    ),
      );
  }
}
class vehiculedata {
  final String idvehicule , idclient,code,codevehicule;
  final String immatriculation;
  final String marque,categorie,annee;
  vehiculedata(this.idvehicule , this.idclient ,this.immatriculation , this.marque , this.categorie , this.annee , this.code,this.codevehicule);
}
class vehiculedata2 {
  final String idvehicule ,code,codevehicule;
  final String immatriculation;
  final String marque,categorie,annee;
  vehiculedata2(this.idvehicule , this.immatriculation , this.marque , this.categorie , this.annee , this.code,this.codevehicule);
}
