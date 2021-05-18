class MyRoute {
  final String name;
  final bool favorite;
  final List<dynamic> coordinates;
  final String date;
  final String timeTaken;
  final String distance;
  final String userUid;

  MyRoute({
    this.name,
    this.favorite,
    this.coordinates,
    this.date,
    this.timeTaken,
    this.distance,
    this.userUid,
  });

  MyRoute.fromData(Map<String, dynamic> data)
      : name = data['name'],
        favorite = data['favorite'],
        coordinates = data['coordinates'],
        date = data['date'],
        timeTaken = data['timeTaken'],
        distance = data['distance'],
        userUid = data['userUid'];

  Map<String, dynamic> toJson() => {
      'name': name,
      'favorite': favorite,
      'coordinates': coordinates,
      'date' : date,
      'timeTaken' : timeTaken,
      'distance' : distance,
      'userUid' : userUid,
  };
}