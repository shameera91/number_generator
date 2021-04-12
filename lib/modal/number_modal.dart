class NumberModal {
  NumberModal(this.phoneNumber);
  final String phoneNumber;

  factory NumberModal.fromJson(Map<String, dynamic> json) => NumberModal(
        json['full_number'],
      );
}
