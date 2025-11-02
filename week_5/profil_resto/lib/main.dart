import 'package:flutter/material.dart';

void main() {
  runApp(const RestoApp());
}

class RestoApp extends StatelessWidget {
  const RestoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestoProfilePage(),
    );
  }
}

class RestoProfilePage extends StatelessWidget {
  const RestoProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Resto'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama Resto
            const Center(
              child: Text(
                'Rm. Sedap Rasa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Gambar profil resto
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/resto.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Baris ikon email dan lokasi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.email, color: Colors.orange),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email: sedaprasa@gmail.com')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.map, color: Colors.orange),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lokasi: Jl. Merdeka No.45')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Deskripsi
            const Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rm. Sedap Rasa menyajikan berbagai masakan nusantara '
              'dengan cita rasa autentik. Kami menggunakan bahan segar '
              'dan bumbu pilihan untuk memberikan pengalaman kuliner terbaik.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Daftar Menu
            const Text(
              'Menu Favorit:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Nasi Goreng Spesial'),
                Text('• Ayam Bakar Madu'),
                Text('• Soto Ayam Kampung'),
                Text('• Es Teh Manis'),
              ],
            ),
            const SizedBox(height: 20),

            // Alamat
            const Text(
              'Alamat:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Jl. Merdeka No. 45, Bojonegoro, Jawa Timur'),
            const SizedBox(height: 20),

            // Jam buka
            const Text(
              'Jam Buka:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Senin - Minggu: 08.00 - 22.00'),
          ],
        ),
      ),
    );
  }
}
