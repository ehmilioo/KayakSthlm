class TheUser {
  final String uid;
  final String username;
  final String email;
  final String experience;
  final int age;
  TheUser({ 
      this.uid, 
      this.email, 
      this.username, 
      this.experience,
      this.age,
    });

  String getName(){
    return uid;
  }


  TheUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        username = data['username'],
        email = data['email'],
        experience = data['experience'],
        age = data['age'];

  Map<String, dynamic> toJson() => {
      'username': username,
      'email': email,
      'uid': uid,
      'experience' : experience,
      'age' : age,
    };
}


