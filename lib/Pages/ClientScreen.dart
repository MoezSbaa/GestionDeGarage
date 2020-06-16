import 'dart:math';

import 'package:auto_center/Pages/AddData.dart';
import 'package:auto_center/Pages/Profile.dart';
import 'package:auto_center/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ButtomNavigationPage.dart';


class CScreen extends StatelessWidget {
//
//  Future<List<Client_data>> _getClient() async{
//    var data = await http.get("http://www.json-generator.com/api/json/get/bUxGCqcDpK?indent=2");
//    var jsondata = json.decode(data.body);
//    List<Client_data> clients = [];
//    for (var i in jsondata){
//      Client_data client = Client_data(i["index"], i["about"], i["email"], i["name"], i["picture"]);
//      clients.add(client);
//    }
//    return clients;
//  }

  Future<List<Client_data>> _getClient() async{
    String url="http://192.168.1.6/PHP/MyApp/getData.php";
    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"});
    var  resbody = json.decode(res.body);
    List<Client_data> clients = [];
    for (var i in resbody){
      Client_data client = Client_data(i["id"], i["firstname"], i["lastname"], i["email"], i["price"] , i["autotype"]);
      clients.add(client);
    }
    return clients;
  }
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    getData();
  }


  getData() async {
      String url="http://192.168.1.6/PHP/MyApp/getData.php";
      var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"});
      var  resbody = json.decode(res.body);
      return resbody;
  }
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Client");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title:cusSearchBar ,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                if(this.cusIcon.icon == Icons.search){
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Client"
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                }else {
                  this.cusSearchBar = Text("Client");
                  this.cusIcon = Icon(Icons.search);
                }
              },
              icon: cusIcon,
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text('auto-center@gmail.com'),
                accountName: Text("Mécanicien"),
                currentAccountPicture:CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://cdn.dribbble.com/users/4650/screenshots/6021728/toyocar_mascot.jpg"
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context:context,
                        builder:(context){
                          return AlertDialog(
                            title: Text("Adding new account..."),
                          );
                        }
                      );
                    },
                    child:  CircleAvatar(
                    child: Icon(Icons.add),
                  )
                  ),
                ],
              ),
              Padding (
                padding: EdgeInsets.only(top : 20),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.user),
                title: Text("Profile"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())); // with back
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.plus),
                title: Text("Add Client"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddData())); // with back
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.cog),
                title: Text(" Settings"),
              ),
              Divider(),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.signOutAlt),
                    title: Text("Sign Out"),
                    onTap: (){
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (BuildContext context) => MyApp()));                    },
                  ),
                ),
              )
            ],
          ),
        ),
        body:  new RefreshIndicator(

          onRefresh: _handleRefresh,
          child:Container(
              child: FutureBuilder(
            future: _getClient(),
            builder: (BuildContext context  , AsyncSnapshot snapshot){
              if (snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                }else{
                  return ListView.builder(

                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context , int index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
//                        snapshot.data[index].picture
                      'http://randomuser.me/api/portraits/men/${next(0, 20)}.jpg'
                      ),
                    ),
                    title: Text(snapshot.data[index].firstname ),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index])));
                  },

                  );

                },
              );
              }
            },
          ),

        ),
        ),
      ),
      length: 2,
    );

  }

    Future<Null> _handleRefresh() async{
    await new Future.delayed(new Duration(seconds: 2));
      getData();
      return null;
  }
}


class DetailPage extends StatelessWidget {

  final Client_data client ;
  DetailPage(this.client);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.firstname),
      ),
    );
  }
}

// class Client_data {
//  final int index;
//  final String about;
//  final String email , name ,picture;
//  Client_data(this.index , this.about , this.email , this.name , this.picture);
//}
class Client_data {
  final String id;
  final String firstname;
  final String lastname , email ,price,autotype;
  Client_data(this.id , this.lastname , this.firstname , this.email , this.price,this.autotype);

}