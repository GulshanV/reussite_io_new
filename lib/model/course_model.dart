class Course{

  dynamic id;
  dynamic createDate;
  dynamic lastUpdateDate;
  dynamic durationInMinutes;
  dynamic name;
  dynamic language;
  dynamic imageUrl;
  List<Grades> arrGrades = [];
  List<Prices> prices = [];
  Subject subject;

  Course.empty(){

  }

  Course.fromJSON(Map<String,dynamic> map){
    id = map['id'];
    createDate = map['createDate'];
    subject = Subject.fromJSON(map['subject']);
    lastUpdateDate = map['lastUpdateDate'];
    durationInMinutes = map['durationInMinutes'];
    name = map['name'];
    language = map['language'];
    if(map.containsKey(imageUrl))
       imageUrl = map['imageUrl'];
    arrGrades=(map['grades'] as List).map((e) => Grades.fromJSON(e)).toList();
    prices=(map['prices'] as List).map((e) => Prices.fromJSON(e)).toList();
  }

  Course.fromBooking(Map<String,dynamic> map){
    id = map['id'];
    name = map['name'];
    arrGrades=(map['grades'] as List).map((e) => Grades.fromJSON(e)).toList();
    subject=Subject.fromJSON(map['subject']);
  }



}

class Grades{
  dynamic grade;
  Grades.fromJSON(dynamic value){
    grade =value;
  }

  @override
  String toString() {
    return '$grade';
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

class Subject{
  dynamic id;
  dynamic name;
  dynamic language;
  Subject.fromJSON(Map<String,dynamic> map){
    id =map['id'];
    name =map['name'];
    language =map['language'];
  }

}