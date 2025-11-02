import 'persegi.dart';
import 'segitiga.dart';
import 'lingkaran.dart';
import 'kubus.dart';

void main() {
  Persegi p = new Persegi(20, 10, 6);
  Segitiga s = new Segitiga(10, 5, 2, 5);
  Lingkaran l = new Lingkaran(7);
  Kubus k = new Kubus(8);

  int luasP = p.getLuas();
  int kelilingP = p.getKeliling();
  double luasS = s.getLuas();
  int kelilingS = s.getKeliling();
  double luasL = l.getLuas();
  double kelilingL = l.getKeliling();
  int luasK = k.getLuas();
  int kelilingK = k.getKeliling();

  print("\nKeliling dan Luas Persegi");
  print('Luas : $luasP');
  print('Keliling : $kelilingP \n');
  print("Keliling dan Luas Segitiga");
  print('Luas : $luasS');
  print('Keliling : $kelilingS');
  print("\nKeliling dan Luas Lingkaran");
  print('Luas : $luasL');
  print('Keliling : $kelilingL \n');
  print("Keliling dan Luas Kubus");
  print('Luas : $luasK');
  print('Keliling : $kelilingK \n');
}
