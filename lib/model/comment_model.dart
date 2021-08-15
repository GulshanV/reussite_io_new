class CommentModel{

   dynamic id;
   Commenter commentur;
   Commenter studentProfile;
   dynamic content;
   dynamic createDate;
  CommentModel.fromJSON(Map<String,dynamic> map){
    id=map['id'];
    content=map['content'];
    createDate=map['createDate'];
    commentur=Commenter.fromJSON(map['commenter']);
    studentProfile=Commenter.fromJSON(map['commenter']);
  }
}
class Commenter{
  dynamic id;
  dynamic firstName;
  dynamic lastName;

  Commenter.fromJSON(Map<String,dynamic> map){
    id=map['id'];
    firstName=map['firstName'];
    lastName=map['lastName'];
  }
}