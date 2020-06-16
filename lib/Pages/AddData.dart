import 'dart:convert';
import 'package:auto_center/Pages/scrclient.dart';
import 'package:auto_center/Pages/test/searchclient.dart';
import 'package:auto_center/helper/client.dart';
import 'package:auto_center/helper/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:better_uuid/uuid.dart';
import 'ButtomNavigationPage.dart';
import 'ClientScreen.dart';
import 'classes/User.dart';


class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  List CarType =
  ["Suzuki Swift", "Land Rover Discover", "Hatchback", "Peugeot", "Fiat S.p.A","Renault"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCar;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCar = _dropDownMenuItems[0].value;

    _dropDownMenuItemsCateg = getDropDownMenuItemsPrice();
    _currentCateg = _dropDownMenuItemsCateg[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String c in CarType) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: c,
          child: new Text(c)
      ));
    }
    return items;
  }

  void changedDropDownItem(String selectedCar) {
    print("Selected car type  $selectedCar, we are going to refresh the UI");
    setState(() {
      _currentCar = selectedCar;
    });
  }


  List categ =
  ["Citadine","Berline","Break","Monospace","4x4" ];
  List<DropdownMenuItem<String>> _dropDownMenuItemsCateg;



  List<DropdownMenuItem<String>> getDropDownMenuItemsPrice() {
    List<DropdownMenuItem<String>> items = new List();
    for (String p in categ) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: p,
          child: new Text(p)
      ));
    }
    return items;
  }

  String _currentCateg;

  void changedDropDownItemCateg(String selectedCateg) {
    setState(() {
      _currentCateg = selectedCateg;
    });
  }

  TextEditingController controllerfirstname = new TextEditingController();
  TextEditingController controllerlastname = new TextEditingController();
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController  controllerannee = new TextEditingController();
  TextEditingController  controllermarque = new TextEditingController();
  var id = Uuid.v1(); // Uuid object

  addDataWithSQF() async {
    client c = new client(controllerfirstname.text, controllerlastname.text, controlleremail.text, id.time.toString());
    int res = await DBHelper().insertClient(c);

  }

  addData() async {
    String url="http://192.168.1.19/PHP/MyApp/adddata.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"},
    body:{
      "firstname" : controllerfirstname.text,
      "lastname": controllerlastname.text ,
      "email" : controlleremail.text,
        }
    );
    var resbody = json.decode(res.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Add Client"),
      ),
      body:(
        Form(
          autovalidate: true,
          child: ListView(
            padding:EdgeInsets.all(20.0),
            children: <Widget>[
              Text('Info Personnel'),
              TextFormField(
                controller: controllerlastname ,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.user , color: Colors.blueAccent,),
                    hintText: "Enter your lastname ",
                    border: InputBorder.none,
                    labelText: "lastname"
                ),
              ),
              TextFormField(
                controller: controllerfirstname ,
                decoration: new InputDecoration(
                  icon: Icon(FontAwesomeIcons.user  , color: Colors.blueAccent),
                  hintText: "Enter your firstname ",
                  border: InputBorder.none,
                  labelText: "firstname"
                ),
              ),

              TextFormField(
                controller: controlleremail ,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    icon: Icon(FontAwesomeIcons.mailBulk , color: Colors.deepOrange,),
                    hintText: "Enter your email ",
                    border: InputBorder.none,
                    labelText: "e-mail"
                ),
              ),
//              SizedBox(height: 20,),
//              Text('Info Vehicule'),
//              TextFormField(
//                controller: controllermarque ,
//                decoration: new InputDecoration(
//                    icon: Icon(FontAwesomeIcons.car , color: Colors.lightBlue,),
//                    hintText: "Enter your car marque ",
//                    border: InputBorder.none,
//                    labelText: "Marque"
//                ),
//              ),
//              DropdownButton(
//                value:_currentCateg ,
//                items: _dropDownMenuItemsCateg,
//                onChanged:changedDropDownItemCateg ,
//                  //icon: Icon(FontAwesomeIcons.listAlt)
//              ),
//              TextFormField(
//                controller: controllerannee ,
//                decoration: new InputDecoration(
//                    icon: Icon(FontAwesomeIcons.calendar , color: Colors.deepPurpleAccent,),
//                    hintText: "Enter Year ",
//                    border: InputBorder.none,
//                    labelText: "Année"
//                ),
//              ),
                SizedBox(height: 20,),
              RaisedButton(
                color: Colors.deepPurple,
                child:new Text("Ajouter" ,style: TextStyle(color: Colors.white),),
                onPressed: () {
                  addDataWithSQF();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigationPage()));
                },
                textColor: Colors.black,
                elevation: 15,
                padding: const EdgeInsets.all(15.0),
              )
            ],
          ),
        )
      ),
    );
  }


}


