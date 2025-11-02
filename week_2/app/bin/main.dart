import 'nilaiPBB.dart';

void main(){
  nilaiPBB n = new nilaiPBB();
  n.inputMhs();
  n.hitungNilai();
  n.cetakNilai();
  nilaiPBB n2 = new nilaiPBB();
  n2.nim = "B12";
  n2.nama = "Rani";
  n2.nilaiTugas = 80;
  n2.nilaiUts = 90;
  n2.nilaiUas = 90;
  n2.hitungNilai();
  n2.cetakNilai();
}