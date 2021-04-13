class Country {
  Country(this.countryId, this.name, this.retry);
  final int countryId;
  final String name;
  final int retry;

  factory Country.fromJson(Map<dynamic, dynamic> json) => Country(
        json['id'],
        json['eng'],
        json['retry'],
      );
}
