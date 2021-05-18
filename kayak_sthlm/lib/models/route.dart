class Route {
  final String name;
  final bool favorite;
  final List<dynamic> coordinates;
  final DateTime date;
  Route({
    this.name,
    this.favorite,
    this.coordinates,
    this.date,
  });

  Route.fromData(Map<String, dynamic> data)
      : name = data['username'],
        favorite = data['email'],
        coordinates = data['experience'],
        date = data['age'];

  Map<String, dynamic> toJson() => {
      'name': name,
      'favorite': favorite.toString(),
      'coordinates': coordinates,
      'date' : date,
    };
}


