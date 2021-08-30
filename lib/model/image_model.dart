class ImageModel{
  String image;
  String childId;

  ImageModel({this.image,this.childId});

  ImageModel.fromJSON(Map<String,dynamic> map){
    image=map['image'];
    childId=map['childId'];
  }

  toMap()=>{
    'image':image,
    'childId':childId
  };
}