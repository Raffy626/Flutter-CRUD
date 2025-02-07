class Catatan {
  int? id;
  String judul;
  String isi;

  Catatan({this.id, required this.judul, required this.isi});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
    };
  }

  factory Catatan.fromMap(Map<String, dynamic> map) {
    return Catatan(
      id: map['id'],
      judul: map['judul'],
      isi: map['isi'],
    );
  }
}
