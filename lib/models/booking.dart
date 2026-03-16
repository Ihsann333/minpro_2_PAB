class Booking {

  int? id;
  String namaTamu;
  String nomorKamar;
  String checkIn;
  String checkOut;
  int harga;

  Booking({
    this.id,
    required this.namaTamu,
    required this.nomorKamar,
    required this.checkIn,
    required this.checkOut,
    required this.harga,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {

    return Booking(
      id: json['id'],
      namaTamu: json['nama_tamu'],
      nomorKamar: json['nomor_kamar'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      harga: json['harga'],
    );

  }

  Map<String, dynamic> toJson() {

    return {
      'nama_tamu': namaTamu,
      'nomor_kamar': nomorKamar,
      'check_in': checkIn,
      'check_out': checkOut,
      'harga': harga,
    };

  }

}