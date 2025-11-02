import 'package:flutter/material.dart';
import 'models/mahasiswa.dart';

void main() {
  runApp(const BiodataApp());
}

class BiodataApp extends StatelessWidget {
  const BiodataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const BiodataPage(),
    );
  }
}

class BiodataPage extends StatelessWidget {
  const BiodataPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data contoh Mahasiswa
    final mahasiswa = Mahasiswa(
      nim: 'A11.2023.15193',
      nama: 'Albert Kolin',
      alamat: 'Jl. Nakula Raya No. 36, Semarang Tengah',
      email: 'albertog4taz28@gmail.com',
      noHp: '+62 812-4688-1584',
      ipk: 3.85,
      foto: 'assets/profile.jpg',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata Mahasiswa'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Foto Profil
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(mahasiswa.foto),
                ),
                const SizedBox(height: 16),
                Text(
                  mahasiswa.nama,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const Divider(height: 24, thickness: 1),
                infoRow(Icons.badge, 'NIM', mahasiswa.nim),
                infoRow(Icons.home, 'Alamat', mahasiswa.alamat),
                infoRow(Icons.email, 'Email', mahasiswa.email),
                infoRow(Icons.phone, 'No. HP', mahasiswa.noHp),
                infoRow(Icons.school, 'IPK', mahasiswa.ipk.toStringAsFixed(2)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper info baris
  static Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}