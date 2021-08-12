class Student {
  dynamic id;
  dynamic parentId;
  dynamic email;
  dynamic lastName;
  dynamic firstName;
  dynamic schoolName;
  dynamic grade;
  dynamic schoolBoard;
  dynamic conferenceUrl;
  dynamic createDate;
  dynamic onlineStatus;
  dynamic termCondionApproved;

  Student.empty() {}

  Student.fromJSON(Map<String, dynamic> map) {
    id = map['id'];
    parentId = map['studentParentId'];
    email = map['email'];
    lastName = map['lastName'];
    firstName = map['firstName'];
    schoolName = map['schoolName'];
    grade = map['grade'];
    schoolBoard = map['schoolBoard'];
    conferenceUrl = map['conferenceUrl'];
    createDate = map['createDate'];
    onlineStatus = map['onlineStatus'];
    termCondionApproved = map['termCondionApproved'];
  }

  dynamic studentParentId;
  Student.fromDetails(Map<String,dynamic> map){
    id=map['id'];
    lastName=map['lastName'];
    firstName=map['firstName'];
    studentParentId=map['studentParentId'];
  }
}
