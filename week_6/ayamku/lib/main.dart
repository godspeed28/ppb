import 'package:flutter/material.dart';
import 'ayam.dart';

void main() {
  runApp(const AyamKuApp());
}

class AyamKuApp extends StatelessWidget {
  const AyamKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AyamKuHomePage(),
    );
  }
}

class AyamKuHomePage extends StatefulWidget {
  const AyamKuHomePage({super.key});

  @override
  State<AyamKuHomePage> createState() => _AyamKuHomePageState();
}

class _AyamKuHomePageState extends State<AyamKuHomePage> {
  // daftar produk ayam
  final List<Ayam> listAyam = [
    Ayam(
        nama: 'Ayam Goreng Original',
        deskripsi: 'Ayam goreng renyah dengan bumbu khas.',
        harga: 25000,
        gambar: 'assets/ayam1.jpg'),
    Ayam(
        nama: 'Ayam Bakar Madu',
        deskripsi: 'Ayam bakar manis gurih dengan madu alami.',
        harga: 30000,
        gambar: 'assets/ayam2.jpg'),
    Ayam(
        nama: 'Ayam Geprek',
        deskripsi: 'Ayam geprek pedas level 1-5.',
        harga: 22000,
        gambar: 'assets/ayam3.jpg'),
    Ayam(
        nama: 'Ayam Crispy',
        deskripsi: 'Ayam crispy gurih ala restoran cepat saji.',
        harga: 27000,
        gambar: 'assets/ayam4.jpg'),
    Ayam(
        nama: 'Ayam Sambal Matah',
        deskripsi: 'Ayam goreng dengan sambal matah khas Bali.',
        harga: 28000,
        gambar: 'assets/ayam5.jpg'),
    Ayam(
        nama: 'Ayam Saus Tiram',
        deskripsi: 'Ayam dengan saus tiram spesial ala chef.',
        harga: 32000,
        gambar: 'assets/ayam6.jpg'),
  ];

  int totalHarga = 0;

  void tambahTotal(int harga) {
    setState(() {
      totalHarga += harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AyamKu'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Display total pembelian
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Total Pembelian: Rp ${totalHarga.toString()}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Grid daftar ayam
            Expanded(
              child: GridView.builder(
                itemCount: listAyam.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final ayam = listAyam[index];
                  return GestureDetector(
                    onTap: () => tambahTotal(ayam.harga),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              child: Image.asset(
                                ayam.gambar,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  ayam.nama,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ayam.deskripsi,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Rp ${ayam.harga}',
                                  style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
