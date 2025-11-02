import 'mahasiswa.dart';

class NilaiMahasiswa {
  Mahasiswa mahasiswa;
  double nilaiUts;
  double nilaiTugas;
  double nilaiUas;
  double pNilaiUts = 0;
  double pNilaiTugas = 0;
  double pNilaiUas = 0;
  double nilaiAkhir = 0;
  String nHuruf = '';
  String predikat = '';

  NilaiMahasiswa({
    required this.mahasiswa,
    required this.nilaiUts,
    required this.nilaiTugas,
    required this.nilaiUas,
  });

  void hitungNilai() {
    pNilaiUts = 0.3 * nilaiUts;
    pNilaiTugas = 0.35 * nilaiTugas;
    pNilaiUas = 0.35 * nilaiUas;
    nilaiAkhir = pNilaiUts + pNilaiTugas + pNilaiUas;
    nHuruf = getNilaiHuruf();
    predikat = getPredikat();
  }

  String getNilaiHuruf() {
    if (nilaiAkhir >= 85) return 'A';
    else if (nilaiAkhir >= 75) return 'B';
    else if (nilaiAkhir >= 65) return 'C';
    else if (nilaiAkhir >= 50) return 'D';
    else return 'E';
  }

  String getPredikat() {
    switch (nHuruf) {
      case 'A':
        return 'Sangat Baik';
      case 'B':
        return 'Baik';
      case 'C':
        return 'Cukup';
      case 'D':
        return 'Kurang';
      default:
        return 'Gagal';
    }
  }
}

