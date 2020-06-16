
class depenses{
  int ID_COLUMN_DEPENSES;
  String DATEE_DEPENSES , MONTANT_DEPENSES , DESCRIPTION_DEPENSES , CODE_INTERVENTION_DEPENSES , CODE_VEHICULE_DEPENSES;

  depenses( this.DATEE_DEPENSES , this.MONTANT_DEPENSES , this.DESCRIPTION_DEPENSES , this.CODE_INTERVENTION_DEPENSES , this.CODE_VEHICULE_DEPENSES);

  depenses.fromMap(dynamic obj){
    this.ID_COLUMN_DEPENSES = obj["iddepenses"];
    this.DATEE_DEPENSES = obj["datee"];
    this.MONTANT_DEPENSES = obj["montant"];
    this.DESCRIPTION_DEPENSES = obj["descriptionn"];
    this.CODE_INTERVENTION_DEPENSES = obj["codeintervention"];
    this.CODE_VEHICULE_DEPENSES = obj["codevehicule"];
  }

  int get iddepenses => ID_COLUMN_DEPENSES;
  String get datee => DATEE_DEPENSES;
  String get montant => MONTANT_DEPENSES;
  String get descriptionn => DESCRIPTION_DEPENSES;
  String get codeintervention => CODE_INTERVENTION_DEPENSES;
  String get codevehicule => CODE_VEHICULE_DEPENSES;

  Map<String , dynamic> toMap(){
    var map = Map<String , dynamic>();
    map["datee"]=DATEE_DEPENSES;
    map["montant"]=MONTANT_DEPENSES;
    map["descriptionn"]=DESCRIPTION_DEPENSES;
    map["codeintervention"]=CODE_INTERVENTION_DEPENSES;
    map["codevehicule"]=CODE_VEHICULE_DEPENSES;

    return map;
  }

}


