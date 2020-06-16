import 'dart:math';
import 'package:auto_center/Pages/vehicule/listvehicule.dart';
import 'package:auto_center/helper/DBHelper.dart';
import 'package:auto_center/helper/client.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../AddData.dart';
import '../ButtomNavigationPage.dart';
import '../Profile.dart';
import 'DetailPage.dart';


//void main() => runApp(searchclientapp());
//
//class searchclientapp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return DynamicTheme(
//      defaultBrightness: Brightness.light,
//      data: (Brightness) => new ThemeData(
//          primarySwatch: Colors.deepPurple, brightness: Brightness
//      ),
//      themedWidgetBuilder: (context, theme) {
//        return new MaterialApp(
//          title: "App",
//          theme: theme,
//          home: searchclient(),
//        );
//      },
//    );
//  }
//}

class searchclient extends StatefulWidget {
  @override
  _searchclientState createState() => _searchclientState();
}

class _searchclientState extends State<searchclient> {


  List data = [];
  List unfilterData = [];
  List<Client_data> clients = [];

  List<client> datawithsqf1 = [] ,datawithsqf2 = [] ;
  List unfilterDatawithsqf = [];

  Future<bool> loadJsonDataSQF() async {
    data = await DBHelper().getClients();
    setState(() {

      this.unfilterData = data;

    });
    return true;
  }

  Future<bool> loadJsonData() async {
    String url = "http://192.168.1.19/PHP/MyApp/getData.php";
    var res = await http
        .post(Uri.encodeFull(url), headers: {"Accept": "Application/json"});
    setState(() {
      data = json.decode(res.body);
      this.unfilterData = data;
    });
    return true;
  }

  Future _future;

  @override
  void initState() {
    super.initState();
    _future = loadJsonDataSQF();
  }

//  Future<List<Client_data>> _getClient() async{
//    String url="http://192.168.1.13/PHP/MyApp/getData.php";
//    var res = await http.post(Uri.encodeFull(url) , headers : {"Accept" : "Application/json"});
//    var  resbody = json.decode(res.body);
//    data = json.decode(res.body);
//    this.unfilterData = data;
//    for (var i in resbody){
//      Client_data client = Client_data(i["idclient"], i["firstname"], i["lastname"], i["email"],i["code"]);
//      clients.add(client);
//    }
//    return clients;
//  }
  SearchData(str) {
    var strExiste = str.length > 0 ? true : false;
    if (strExiste) {
      var filterData = [];
      for (var i = 0; i < unfilterData.length; i++) {
        print("conteur : "+i.toString());
        String name = unfilterData[i].LAST_NAME.toUpperCase();
        if (name.contains(str.toUpperCase())) {
          filterData.add(unfilterData[i]);
        }
        setState(() {
          this.data = filterData;
        });
      }
    } else {
      setState(() {
        this.data = this.unfilterData;
      });
    }
  }

  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);
  @override
//  Future<Null> _refresh() async  {
//      await Future.delayed(Duration(seconds: 1));
//      build(context);
//      return null;
//  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  Future _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    loadJsonDataSQF();
  }
  var b = "Dark Theme";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client List"),
        actions: <Widget>[
//            FlatButton(
//              textColor: Colors.white,
//              child: Text(b),
//              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//              onPressed: () {
//                if (Theme.of(context).brightness == Brightness.light) {
//                  b = "Light Theme";
//                } else {
//                  b = "Dark Theme";
//                }
//                DynamicTheme.of(context).setBrightness(
//                    Theme.of(context).brightness == Brightness.light
//                        ? Brightness.dark
//                        : Brightness.light);
//              },
//            ),


        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('auto-center@gmail.com'),
              accountName: Text("Mécanicien"),
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular( 50.0),
                      bottomLeft: Radius.circular( 50.0),
                    bottomRight: Radius.circular( 50.0),

                  ),
                child: new Image.asset('Images/aa.jpg'),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Adding new account..."),
                            );
                          });
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.add),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.user),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile())); // with back
              },
            ),
//            ListTile(
//              leading: Icon(FontAwesomeIcons.plus),
//              title: Text("Add Client"),
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context) => AddData())); // with back
//              },
//            ),
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
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyApp()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        key: _refreshIndicatorKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {
                  SearchData(value);
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var name = data[index].LAST_NAME;
                    var email = data[index].EMAIL;
                    var code = data[index].CODE_CLIENT;
                    return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                new listvehicule(
                                    list: data,
                                    index: index,
                                    code: code))),
                        child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: new Image.asset('Images/randuser/${next(0,15)}.jpg'),
                            ),
                          title: Text(name),
                          subtitle: Text(email),
                        ));
                  }),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddData())); // with back
        },
      ),
    );
  }
}

//class DetailPage extends StatelessWidget {
//
//  final Client_data client ;
//  DetailPage(this.client);
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(client.firstname),
//      ),
//    );
//  }
//}
class Client_data {
  final String idclient, code;
  final String firstname;
  final String lastname, email;

  Client_data(
      this.idclient, this.lastname, this.firstname, this.email, this.code);
}

