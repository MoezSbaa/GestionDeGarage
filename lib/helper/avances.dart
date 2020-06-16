
class avances{
  int ID_COLUMN_AVANCES;
  String DATEE_AVANCES , MONTANT_AVANCES , DESCRIPTION_AVANCES , CODE_INTERVENTION_AVANCES , CODE_VEHICULE_AVANCES;

  avances( this.DATEE_AVANCES , this.MONTANT_AVANCES , this.DESCRIPTION_AVANCES , this.CODE_INTERVENTION_AVANCES , this.CODE_VEHICULE_AVANCES);

  avances.fromMap(dynamic obj){
    this.ID_COLUMN_AVANCES = obj["idavances"];
    this.DATEE_AVANCES = obj["datee"];
    this.MONTANT_AVANCES = obj["montant"];
    this.DESCRIPTION_AVANCES = obj["descriptionn"];
    this.CODE_INTERVENTION_AVANCES = obj["codeintervention"];
    this.CODE_VEHICULE_AVANCES = obj["codevehicule"];
  }

  int get idavances => ID_COLUMN_AVANCES;
  String get datee => DATEE_AVANCES;
  String get montant => MONTANT_AVANCES;
  String get descriptionn => DESCRIPTION_AVANCES;
  String get codeintervention => CODE_INTERVENTION_AVANCES;
  String get codevehicule => CODE_VEHICULE_AVANCES;

  Map<String , dynamic> toMap(){
    var map = Map<String , dynamic>();
    map["datee"]=DATEE_AVANCES;
    map["montant"]=MONTANT_AVANCES;
    map["descriptionn"]=DESCRIPTION_AVANCES;
    map["codeintervention"]=CODE_INTERVENTION_AVANCES;
    map["codevehicule"]=CODE_VEHICULE_AVANCES;

    return map;
  }

}


