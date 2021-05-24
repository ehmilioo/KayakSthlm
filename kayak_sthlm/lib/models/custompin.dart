class CustomPin {
  final String username;
  final String name;
  final String desc;
  final double lat;
  final double lng;

  CustomPin({
    this.username,
    this.name,
    this.desc,
    this.lat,
    this.lng,
  });

  CustomPin.fromData(Map<String, dynamic> data)
      : username = data['usernameq'],
        name = data['name'],
        desc = data['desc'],
        lat = data['lat'],
        lng = data['lng'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'name': name,
        'desc': desc,
        'lat': lat,
        'lng': lng,
      };
}
