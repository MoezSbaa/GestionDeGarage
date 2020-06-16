
class client{
 int ID_COLUMN_CLIENT;
 String FIRST_NAME , LAST_NAME , EMAIL , CODE_CLIENT;

 client( this.FIRST_NAME , this.LAST_NAME , this.EMAIL , this.CODE_CLIENT);

 client.fromMap(dynamic obj){
   this.ID_COLUMN_CLIENT = obj["idclient"];
   this.FIRST_NAME = obj["firstname"];
   this.LAST_NAME = obj["lastname"];
   this.EMAIL = obj["email"];
   this.CODE_CLIENT = obj["code"];
 }

 int get idclient => ID_COLUMN_CLIENT;
 String get firstname => FIRST_NAME;
 String get lastname => LAST_NAME;
 String get email => EMAIL;
 String get code => CODE_CLIENT;

 Map<String , dynamic> toMap(){
   var map = Map<String , dynamic>();
   map["firstname"]=FIRST_NAME;
   map["lastname"]=LAST_NAME;
   map["email"]=EMAIL;
   map["code"]=CODE_CLIENT;

   return map;
 }

}


