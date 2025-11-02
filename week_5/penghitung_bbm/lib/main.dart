import 'package:flutter/material.dart';
import 'bbm.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Kalkulator BBM",
      home: MainHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  // Daftar jenis BBM
  final listBbm = <BBM>[
    BBM(nama: 'Premium', harga: 10000),
    BBM(nama: 'Pertamax', harga: 14000),
    BBM(nama: 'Pertamax Turbo', harga: 16600),
    BBM(nama: 'Solar', harga: 6800),
  ];

  // Controller untuk input
  final TextEditingController tujuanCtrl = TextEditingController();
  final TextEditingController jarakCtrl = TextEditingController();

  String textHasil = '';
  BBM? selectedBBM;

  _MainHomePageState() {
    selectedBBM = listBbm[0];
  }

  void setHasil() {
    if (jarakCtrl.text.isEmpty) {
      setState(() {
        textHasil = 'Masukkan jarak terlebih dahulu!';
      });
      return;
    }

    final jarak = double.tryParse(jarakCtrl.text);
    if (jarak == null) {
      setState(() {
        textHasil = 'Jarak harus berupa angka!';
      });
      return;
    }

    double biaya = selectedBBM!.harga * (jarak / 10);
    setState(() {
      textHasil =
          'Perkiraan biaya ke ${tujuanCtrl.text.isEmpty ? "(tujuan tidak diisi)" : tujuanCtrl.text}:\n'
          'BBM: ${selectedBBM!.nama}\n'
          'Total: Rp ${biaya.toStringAsFixed(0)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator BBM"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Hitung BBM & Biaya Perjalanan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),

            // Input tujuan
            const Text("Nama Tujuan"),
            TextField(
              controller: tujuanCtrl,
              decoration: const InputDecoration(
                hintText: 'Masukkan tujuan perjalanan',
              ),
            ),
            const SizedBox(height: 20),

            // Input jarak
            const Text("Jarak Tempuh (km)"),
            TextField(
              controller: jarakCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan jarak dalam km',
              ),
            ),
            const SizedBox(height: 20),

            // Pilihan BBM
            const Text("Pilih Jenis BBM"),
            DropdownButton<BBM>(
              isExpanded: true,
              value: selectedBBM,
              items: listBbm.map((BBM item) {
                return DropdownMenuItem<BBM>(
                  value: item,
                  child: Text(item.nama),
                );
              }).toList(),
              onChanged: (BBM? newVal) {
                setState(() {
                  selectedBBM = newVal;
                });
              },
            ),
            const SizedBox(height: 30),

            // Tombol hitung
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: setHasil,
                child: const Text("Hitung BBM"),
              ),
            ),
            const SizedBox(height: 20),

            // Hasil
            Text(
              textHasil,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
