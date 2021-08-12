class ParentModel{

  dynamic id;
  dynamic email;
  dynamic phoneNumber;
  dynamic activationCode;
  dynamic activationDate;
  dynamic deleteDate;
  dynamic createDate;
  dynamic firstName;
  dynamic lastName;
  dynamic language;
  dynamic countryCode;
  dynamic lastUpdateDate;

  ParentModel.empty(){}
  ParentModel.fromJSON(Map<String,dynamic> map){
     id=map['id'];
     email=map['email'];
     phoneNumber=map['phoneNumber'];
     activationCode=map['activationCode'];
     activationDate=map['activationDate'];
     deleteDate=map['deleteDate'];
     createDate=map['createDate'];
     firstName=map['firstName'];
     firstName=map['firstName'];
     lastName=map['lastName'];
     language=map['language'];
     countryCode=map['countryCode'];
     lastUpdateDate=map['lastUpdateDate'];
  }
}