// barang_model.dart
class Barang {
  String kdBrg;
  String nmBrg;
  String satuan;
  String harga; // atau double jika dikonversi
  String stok; // atau int jika dikonversi
  String? gambar; // field ini harus ada
  DateTime? createdAt;
  DateTime? updatedAt;

  Barang({
    required this.kdBrg,
    required this.nmBrg,
    required this.satuan,
    required this.harga,
    required this.stok,
    this.gambar,
    this.createdAt,
    this.updatedAt,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      kdBrg: json['kd_brg'] ?? '',
      nmBrg: json['nm_brg'] ?? '',
      satuan: json['satuan'] ?? '',
      harga: json['harga'] ?? '0',
      stok: json['stok'] ?? '0',
      gambar: json['gambar'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
