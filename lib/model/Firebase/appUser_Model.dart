class AppUser{

  String email;
  String? id;
  String? password;
  String userName;
  String city;
  String? image;
  String? phone;

  AppUser({required this.email,required this.userName,required this.city,this.password,this.id,this.image,this.phone});
  Map<String,dynamic> toMap(){
    return{
      "email":email,
      "userName":userName,
      "city":city,
      "id":id,
      "image":image,
      "phone":phone,

    };
  }

 factory AppUser.fromeMap(Map<String,dynamic> map){
    return AppUser(
        email: map["email"] ,
        userName: map["userName"] ,
        city: map["city"] ,
        id: map["id"],
        image:map["image"],
        phone:map["phone"]

    );
  }

}