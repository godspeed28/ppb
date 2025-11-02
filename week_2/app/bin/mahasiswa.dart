void main(){
Mahasiswa mhs = new Mahasiswa();
mhs.nim = 'A11.2023.15193';
mhs.nama = 'Albert Kolin';
mhs.IPK = 3.6;
mhs.view();
}

class Mahasiswa{
String nim = "", nama = "";
double IPK = 0;
Mahasiswa(){
print('~~ Data Mahasiswa ~~');

}
Mahasiswa.m(String nim, String nama, double IPK){
this.nim = nim;this.nama = nama;this.IPK = IPK;
}
void view(){
  print('NIM : $nim');
  print('Nama : $nama');
  print('IPK : $IPK');
}
}