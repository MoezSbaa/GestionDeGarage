
class vehicule{

  int ID_COLUMN_VEHICULE;
  String IMMAT_Vehicule , MARQUE , CATEGORIE , ANNEE , CODE_CLIENT_V , CODE_VEHICULE;

  vehicule( this.IMMAT_Vehicule , this.MARQUE , this.CATEGORIE , this.ANNEE, this.CODE_CLIENT_V , this.CODE_VEHICULE );

  vehicule.fromMap(dynamic obj){
    this.ID_COLUMN_VEHICULE = obj["idvehicule"];
    this.IMMAT_Vehicule = obj["immatriculation"];
    this.MARQUE = obj["marque"];
    this.CATEGORIE = obj["categorie"];
    this.ANNEE = obj["annee"];
    this.CODE_CLIENT_V = obj["code"];
    this.CODE_VEHICULE = obj["codevehicule"];
  }

  int get idvehicule => ID_COLUMN_VEHICULE;
  String get immatriculation => IMMAT_Vehicule;
  String get marque => MARQUE;
  String get categorie => CATEGORIE;
  String get annee => ANNEE;
  String get code => CODE_CLIENT_V;
  String get codevehicule => CODE_VEHICULE;

  Map<String , dynamic> toMap(){
    var map = Map<String , dynamic>();
    map["immatriculation"]=IMMAT_Vehicule;
    map["marque"]=MARQUE;
    map["categorie"]=CATEGORIE;
    map["annee"]=ANNEE;
    map["code"]=CODE_CLIENT_V;
    map["codevehicule"]=CODE_VEHICULE;

    return map;
  }

}