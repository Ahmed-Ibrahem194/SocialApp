
class PostModel
{
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(Map<String , dynamic> json)
  {
    name = json['name'];
    text = json['Text'];
    postImage = json['postImage'];
    uId = json['uId'];
    dateTime = json['dateTime'] ;
    image = json['image'];
  }

  Map<String , dynamic> toMap()
  {
    return
      {
        'name' : name,
        'Text' : text,
        'postImage' : postImage,
        'image' : image ,
        'dateTime' : dateTime ,
        'uId' : uId,
      };
  }
}