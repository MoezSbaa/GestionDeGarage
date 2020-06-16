import 'dart:io' as io;
import 'package:auto_center/helper/avances.dart';
import 'package:auto_center/helper/client.dart';
import 'package:auto_center/helper/depenses.dart';
import 'package:auto_center/helper/intervention.dart';
import 'package:auto_center/helper/vehicule.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{

  static Database _db;
  // ALL TABLES
  static const String TABLE_CLIENT = 'client';
  static const String TABLE_VEHICULE = 'vehicule';
  static const String TABLE_INTERVENTION = 'interventions';
  static const String TABLE_AVANCES = 'avances';
  static const String TABLE_DEPENSES = 'depenses';
  static const String DB_NAME = 'autocenter.db';
  // TABLE CLIENT COLUMNS
  static const String ID_COLUMN_CLIENT = 'idclient';
  static const String FIRST_NAME = 'firstname';
  static const String LAST_NAME = 'lastname';
  static const String EMAIL = 'email';
  static const String CODE_CLIENT = 'code';
  // TABLE VEHICULE COLUMNS
  static const String ID_COLUMN_VEHICULE = 'idvehicule';
  static const String IMMAT_Vehicule = 'immatriculation';
  static const String MARQUE = 'marque';
  static const String CATEGORIE = 'categorie';
  static const String ANNEE = 'annee';
  static const String CODE_CLIENT_V = 'code';
  static const String CODE_VEHICULE = 'codevehicule';
  // TABLE INTERVENTION COLUMNS
  static const String ID_COLUMN_INTERVENTION = 'idinterventions';
  static const String DATEE = 'datee';
  static const String DESCRIPTION = 'description';
  static const String MONTANT = 'montant';
  static const String ETAT = 'etat';
  static const String CODE_CLIENT_INTERV = 'code';
  static const String CODE_VEHICULE_INTERV = 'codevehicule';
  static const String CODE_INTERVENTION = 'codeintervention';
  // TABLE DEPENSES COLUMNS
  static const String ID_COLUMN_DEPENSES = 'iddepenses';
  static const String DATEE_DEPENSES = 'datee';
  static const String MONTANT_DEPENSES = 'montant';
  static const String DESCRIPTION_DEPENSES = 'descriptionn';
  static const String CODE_INTERVENTION_DEPENSES = 'codeintervention';
  static const String CODE_VEHICULE_DEPENSES = 'codevehicule';
  // TABLE AVANCES COLUMNS
  static const String ID_COLUMN_AVANCES = 'idavances';
  static const String DATEE_AVANCES = 'datee';
  static const String MONTANT_AVANCES = 'montant';
  static const String DESCRIPTION_AVANCES = 'descriptionn';
  static const String CODE_INTERVENTION_AVANCES = 'codeintervention';
  static const String CODE_VEHICULE_AVANCES = 'codevehicule';


  static final DBHelper _instance = new DBHelper.internal();
  DBHelper.internal();
  factory DBHelper()=>_instance;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);
    var db = await openDatabase(path, version: 11, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {

    await db.execute("CREATE TABLE $TABLE_CLIENT ($ID_COLUMN_CLIENT INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , $FIRST_NAME varchar(45) DEFAULT NULL , $LAST_NAME varchar(45) DEFAULT NULL , $EMAIL varchar(45) DEFAULT NULL , $CODE_CLIENT varchar(45) DEFAULT NULL)");
    await db.execute("CREATE TABLE $TABLE_VEHICULE ($ID_COLUMN_VEHICULE INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , $IMMAT_Vehicule varchar(45) DEFAULT NULL , $MARQUE varchar(45) DEFAULT NULL , $CATEGORIE varchar(45) DEFAULT NULL , $ANNEE varchar(45) DEFAULT NULL , $CODE_CLIENT_V varchar(45) DEFAULT NULL , $CODE_VEHICULE varchar(45) DEFAULT NULL)");
    await db.execute("CREATE TABLE $TABLE_INTERVENTION ($ID_COLUMN_INTERVENTION INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , $DATEE varchar(45) DEFAULT NULL , $DESCRIPTION varchar(45) DEFAULT NULL , $MONTANT varchar(45) DEFAULT NULL , $ETAT varchar(45) DEFAULT NULL , $CODE_CLIENT_INTERV varchar(45) DEFAULT NULL , $CODE_VEHICULE_INTERV varchar(45) DEFAULT NULL , $CODE_INTERVENTION varchar(45) DEFAULT NULL)");
    await db.execute("CREATE TABLE $TABLE_DEPENSES ($ID_COLUMN_DEPENSES INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , $DATEE_DEPENSES varchar(45) DEFAULT NULL , $MONTANT_DEPENSES varchar(45) DEFAULT NULL , $DESCRIPTION_DEPENSES varchar(45) DEFAULT NULL , $CODE_INTERVENTION_DEPENSES varchar(45) DEFAULT NULL , $CODE_VEHICULE_DEPENSES varchar(45) DEFAULT NULL)");
    await db.execute("CREATE TABLE $TABLE_AVANCES ($ID_COLUMN_AVANCES INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , $DATEE_AVANCES varchar(45) DEFAULT NULL , $MONTANT_AVANCES varchar(45) DEFAULT NULL , $DESCRIPTION_AVANCES varchar(45) DEFAULT NULL , $CODE_INTERVENTION_AVANCES varchar(45) DEFAULT NULL , $CODE_VEHICULE_AVANCES varchar(45) DEFAULT NULL)");
  }

  Future<int> insertClient(client clt) async{

    var dbcenter = await db;
    int res = await dbcenter.insert(TABLE_CLIENT, clt.toMap());
    print("data client l kollha inserted !!!!!!!");
    return res;
  }

  Future<int> insertVehicule(vehicule v) async{

    var dbcenter = await db;
    int res = await dbcenter.insert(TABLE_VEHICULE, v.toMap());
    print("data vehicule l kollha inserted !!!!!!!");
    return res;
  }

  Future<int> insertInterv(intervention interv) async{

    var dbcenter = await db;
    int res = await dbcenter.insert(TABLE_INTERVENTION, interv.toMap());
    print("data intervention l kollha inserted !!!!!!!");
    return res;
  }

  Future<int> insertDepenses(depenses dep) async{

    var dbcenter = await db;
    int res = await dbcenter.insert(TABLE_DEPENSES, dep.toMap());
    print("data depenses l kollha inserted !!!!!!!");
    return res;
  }

  Future<int> insertAvances(avances avan) async{

    var dbcenter = await db;
    int res = await dbcenter.insert(TABLE_AVANCES, avan.toMap());
    print("data avances l kollha inserted !!!!!!!");
    return res;
  }

  Future<List<client>> getClients() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_CLIENT");
    List<client> clients = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        clients.add(client.fromMap(maps[i]));
      }
    }
    return clients;
  }

  Future<List<vehicule>> getCodeVehicule(String code) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_VEHICULE");
    List<vehicule> v = [];
    if (maps.length > 0) {
     for(int i=0 ; i<maps.length;i++){
       if(maps[i][CODE_CLIENT_V] == code){
          v.add(vehicule.fromMap(maps[i]));
       }
     }
    }
    return v;
  }


  Future<List<vehicule>> getVehicules(String code , String immat) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_VEHICULE");
    List<vehicule> v = [];
    if (maps.length > 0) {
      for(int i=0 ; i<maps.length;i++){
        if(maps[i][CODE_CLIENT_V] == code && maps[i][IMMAT_Vehicule] == immat ){
          v.add(vehicule.fromMap(maps[i]));
        }
      }
    }
    return v;
  }
  Future<List<intervention>> getInterv(String codevehicule ) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_INTERVENTION");
    List<intervention> v = [];
    if (maps.length > 0) {
      for(int i=0 ; i<maps.length;i++){
        if(maps[i][CODE_VEHICULE_INTERV] == codevehicule ){
          v.add(intervention.fromMap(maps[i]));
        }
      }
    }
    return v;
  }

  Future<List<avances>> getAvances(String code,String codevehicule ) async {
    var dbClient = await db;
    String codeinter;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_INTERVENTION");
    List<Map> maps2 = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_AVANCES");
    List<avances> v = [];

      for(int i=0 ; i<maps.length;i++){
        if(maps[i][CODE_CLIENT_INTERV] == code && maps[i][CODE_VEHICULE_INTERV] == codevehicule ){
           codeinter = maps[i][CODE_INTERVENTION];
          break;
        }
      }
      for(int j=0 ; j<maps2.length;j++){
        if(maps2[j][CODE_VEHICULE_AVANCES] == codevehicule && maps2[j][CODE_INTERVENTION_AVANCES] == codeinter ){
          v.add(avances.fromMap(maps2[j]));
        }
      }

    return v;
  }


   getcodeInterv(String code, String codevehicule) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_INTERVENTION");
    String v;
    if (maps.length > 0) {
      for(int i=0 ; i<maps.length;i++){
        if(maps[i][CODE_CLIENT_INTERV] == code && maps[i][CODE_VEHICULE_INTERV] == codevehicule){
          v = maps[i][CODE_INTERVENTION] ;
        }
      }
    }
    return v;
  }


  Future<List<depenses>> getDepenses(String code,String codevehicule ) async {
    var dbClient = await db;
    String codeinter;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_INTERVENTION");
    List<Map> maps2 = await dbClient.rawQuery(
        "SELECT * FROM $TABLE_DEPENSES");
    List<depenses> v = [];

    for(int i=0 ; i<maps.length;i++){
      if(maps[i][CODE_CLIENT_INTERV] == code && maps[i][CODE_VEHICULE_INTERV] == codevehicule ){
        codeinter = maps[i][CODE_INTERVENTION];
        break;
      }
    }
    for(int j=0 ; j<maps2.length;j++){
      if(maps2[j][CODE_VEHICULE_DEPENSES] == codevehicule && maps2[j][CODE_INTERVENTION_DEPENSES] == codeinter ){
        v.add(depenses.fromMap(maps2[j]));
      }
    }

    return v;
  }



}