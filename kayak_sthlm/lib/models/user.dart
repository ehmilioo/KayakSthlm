class TheUser {
  final String uid;
  final String username;
  final String email;
  final String experience;
  final String age;
  final String gender;
  TheUser({ 
      this.uid, 
      this.email, 
      this.username, 
      this.experience,
      this.age,
      this.gender,
    });

  String getName(){
    return uid;
  }


  TheUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        username = data['username'],
        email = data['email'],
        experience = data['experience'],
        age = data['age'],
        gender = data['gender'];

  Map<String, dynamic> toJson() => {
      'username': username,
      'email': email,
      'uid': uid,
      'experience' : experience,
      'age' : age,
      'gender' : gender,
    };
}


