class FireInfo {
  String county;
  String countyCode;
  String municipality;
  String municipalityCode;
  String status;
  String startDate;
  String revisionDate;
  String description;
  String authority;
  String url;
  Map<String, dynamic> fireProhibition;

  FireInfo(Map<String, dynamic> map) {
    this.county = map['county'];
    this.countyCode = map['countyCode'];
    this.municipality = map['municipality'];
    this.municipalityCode = map['municipalityCode'];
    this.fireProhibition = map['fireProhibition'];
    this.status = fireProhibition['status'];
    this.startDate = fireProhibition['startDate'];
    this.revisionDate = fireProhibition['revisionDate'];
    this.description = fireProhibition['description'];
    this.authority = fireProhibition['authority'];
    this.url = fireProhibition['url'];
  }
}
