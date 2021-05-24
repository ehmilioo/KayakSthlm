class CustomPin {
  final String name;
  final String desc;
  final double lat;
  final double lng;

  CustomPin({
    this.name,
    this.desc,
    this.lat,
    this.lng,
  });

  CustomPin.fromData(Map<String, dynamic> data)
      : name = data['name'],
        desc = data['desc'],
        lat = data['lat'],
        lng = data['lng'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'desc': desc,
        'lat': lat,
        'lng': lng,
      };
}
