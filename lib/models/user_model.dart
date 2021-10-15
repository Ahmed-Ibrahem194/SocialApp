
class UserModel
{
  String name;
  String email;
  String phone;
  String uId;
  bool isEmailVerfied;
  String image;
  String cover;
  String bio;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerfied,
    this.image,
    this.bio,
    this.cover,
});

  UserModel.fromJson(Map<String , dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerfied = json['isEmailVerfied'] ;
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String , dynamic> toMap()
  {
    return
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
        'isEmailVerfied' : isEmailVerfied,
        'image' : image ,
        'bio' : bio ,
        'cover' : cover ,
        'uId' : uId,
      };
  }
}