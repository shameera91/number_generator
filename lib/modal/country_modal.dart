class CountryModal {
  CountryModal(this.country, this.countryText);
  final int country;
  final String countryText;

  factory CountryModal.fromJson(Map<String, dynamic> json) => CountryModal(
        json['country'],
        json['country_text'],
      );
}
