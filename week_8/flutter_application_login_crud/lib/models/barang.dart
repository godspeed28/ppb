class Barang {
  int? id;
  String kdBrg;
  String nmBrg;
  int hrgBeli;
  int hrgJual;
  int stok;

  Barang({
    this.id,
    required this.kdBrg,
    required this.nmBrg,
    required this.hrgBeli,
    required this.hrgJual,
    required this.stok,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kdBrg': kdBrg,
      'nmBrg': nmBrg,
      'hrgBeli': hrgBeli,
      'hrgJual': hrgJual,
      'stok': stok,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) => Barang(
    id: map['id'],
    kdBrg: map['kdBrg'],
    nmBrg: map['nmBrg'],
    hrgBeli: map['hrgBeli'],
    hrgJual: map['hrgJual'],
    stok: map['stok'],
  );
}
