import 'package:flutter/material.dart';
import 'models/mahasiswa.dart';
import 'models/nilai_mahasiswa.dart';

void main() {
  runApp(const NilaiApp());
}

class NilaiApp extends StatelessWidget {
  const NilaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nilai Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
      ),
      home: const HitungNilaiPage(),
    );
  }
}

class HitungNilaiPage extends StatefulWidget {
  const HitungNilaiPage({super.key});

  @override
  State<HitungNilaiPage> createState() => _HitungNilaiPageState();
}

class _HitungNilaiPageState extends State<HitungNilaiPage> {
  final _formKey = GlobalKey<FormState>();

  final nimController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final emailController = TextEditingController();
  final noHpController = TextEditingController();
  final ipkController = TextEditingController();
  final utsController = TextEditingController();
  final tugasController = TextEditingController();
  final uasController = TextEditingController();

  final List<NilaiMahasiswa> daftarNilai = [];

  void hitungDanSimpan() {
    if (_formKey.currentState!.validate()) {
      var mhs = Mahasiswa(
        nim: nimController.text,
        nama: namaController.text,
        alamat: alamatController.text,
        email: emailController.text,
        noHp: noHpController.text,
        ipk: double.tryParse(ipkController.text) ?? 0,
        foto: 'assets/profile.jpeg',
      );

      var nilai = NilaiMahasiswa(
        mahasiswa: mhs,
        nilaiUts: double.parse(utsController.text),
        nilaiTugas: double.parse(tugasController.text),
        nilaiUas: double.parse(uasController.text),
      );

      nilai.hitungNilai();

      setState(() {
        daftarNilai.add(nilai);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.teal.shade600,
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Data mahasiswa berhasil disimpan!'),
            ],
          ),
        ),
      );

      _formKey.currentState!.reset();
    }
  }

  void lihatDetail(NilaiMahasiswa nilai) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Nilai ${nilai.mahasiswa.nama}'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIM: ${nilai.mahasiswa.nim}'),
            Text('Nilai UTS: ${nilai.nilaiUts}'),
            Text('Nilai Tugas: ${nilai.nilaiTugas}'),
            Text('Nilai UAS: ${nilai.nilaiUas}'),
            const Divider(),
            Text('Nilai Akhir: ${nilai.nilaiAkhir.toStringAsFixed(2)}'),
            Text('Nilai Huruf: ${nilai.nHuruf}'),
            Text('Predikat: ${nilai.predikat}'),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            label: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (v) => v!.isEmpty ? 'Masukkan $label' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Nilai Mahasiswa'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Input Data Mahasiswa',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      buildInputField(nimController, 'NIM'),
                      buildInputField(namaController, 'Nama'),
                      buildInputField(alamatController, 'Alamat'),
                      buildInputField(emailController, 'Email'),
                      buildInputField(noHpController, 'No. HP'),
                      buildInputField(ipkController, 'IPK', type: TextInputType.number),
                      const Divider(height: 30),
                      const Text(
                        'Input Nilai',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      buildInputField(utsController, 'Nilai UTS', type: TextInputType.number),
                      buildInputField(tugasController, 'Nilai Tugas', type: TextInputType.number),
                      buildInputField(uasController, 'Nilai UAS', type: TextInputType.number),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Hitung & Simpan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: hitungDanSimpan,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            const Text(
              'Daftar Nilai Mahasiswa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (daftarNilai.isEmpty)
              const Text('Belum ada data mahasiswa',
                  style: TextStyle(color: Colors.grey)),
            if (daftarNilai.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: daftarNilai.length,
                itemBuilder: (context, index) {
                  final data = daftarNilai[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(data.mahasiswa.foto),
                        radius: 25,
                      ),
                      title: Text(
                        data.mahasiswa.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('NIM: ${data.mahasiswa.nim}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.nilaiAkhir.toStringAsFixed(1),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            data.nHuruf,
                            style: const TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                      onTap: () => lihatDetail(data),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
