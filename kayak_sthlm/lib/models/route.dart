class MyRoute {
  final String name;
  final bool favorite;
  final List<dynamic> coordinates;
  final String date;

  MyRoute({
    this.name,
    this.favorite,
    this.coordinates,
    this.date,
  });

  MyRoute.fromData(Map<String, dynamic> data)
      : name = data['name'],
        favorite = data['favorite'],
        coordinates = data['coordinates'],
        date = data['date'];

  Map<String, dynamic> toJson() => {
      'name': name,
      'favorite': favorite,
      'coordinates': coordinates,
      'date' : date,
  };
}