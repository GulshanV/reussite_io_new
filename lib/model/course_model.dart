class Course{

  dynamic id;
  dynamic createDate;
  dynamic subject;
  dynamic lastUpdateDate;
  dynamic durationInMinutes;
  dynamic name;
  dynamic language;
  dynamic imageUrl;
  List<Grades> arrGrades = [];

  Course.fromJSON(Map<String,dynamic> map){
    id = map['id'];
    createDate = map['createDate'];
    subject = map['subject'];
    lastUpdateDate = map['lastUpdateDate'];
    durationInMinutes = map['durationInMinutes'];
    name = map['name'];
    language = map['language'];
    if(map.containsKey(imageUrl))
       imageUrl = map['imageUrl'];
    arrGrades=(map['grades'] as List).map((e) => Grades.fromJSON(e)).toList();
  }
}

class Grades{
  dynamic grade;
  Grades.fromJSON(dynamic value){
    grade =value;
  }

}

class Prices{
  dynamic amount;
  dynamic currencyCode;
  Prices.fromJSON(Map<String,dynamic> map){
    amount =map['amount'];
    currencyCode =map['currencyCode'];
  }

}