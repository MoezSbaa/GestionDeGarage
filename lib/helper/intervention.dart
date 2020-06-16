
class intervention{

  int ID_COLUMN_INTERVENTION;
  String DATEE , DESCRIPTION , MONTANT , ETAT , CODE_CLIENT_INTERV , CODE_VEHICULE_INTERV , CODE_INTERVENTION;

  intervention( this.DATEE , this.DESCRIPTION , this.MONTANT , this.ETAT, this.CODE_CLIENT_INTERV , this.CODE_VEHICULE_INTERV , this.CODE_INTERVENTION );

  intervention.fromMap(dynamic obj){
    this.ID_COLUMN_INTERVENTION = obj["idinterventions"];
    this.DATEE = obj["datee"];
    this.DESCRIPTION = obj["description"];
    this.MONTANT = obj["montant"];
    this.ETAT = obj["etat"];
    this.CODE_CLIENT_INTERV = obj["code"];
    this.CODE_VEHICULE_INTERV = obj["codevehicule"];
    this.CODE_INTERVENTION = obj["codeintervention"];
  }

  int get idinterventions => ID_COLUMN_INTERVENTION;
  String get datee => DATEE;
  String get description => DESCRIPTION;
  String get montant => MONTANT;
  String get etat => ETAT;
  String get code => CODE_CLIENT_INTERV;
  String get codevehicule => CODE_VEHICULE_INTERV;
  String get codeintervention => CODE_INTERVENTION;

  Map<String , dynamic> toMap(){
    var map = Map<String , dynamic>();
    map["datee"]=DATEE;
    map["description"]=DESCRIPTION;
    map["montant"]=MONTANT;
    map["etat"]=ETAT;
    map["code"]=CODE_CLIENT_INTERV;
    map["codevehicule"]=CODE_VEHICULE_INTERV;
    map["codeintervention"]=CODE_INTERVENTION;

    return map;
  }

}