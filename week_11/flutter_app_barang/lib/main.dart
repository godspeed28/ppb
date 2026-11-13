import 'package:flutter/material.dart';
import 'package:flutter_app_barang/form_barang.dart';
import 'service.dart';
import 'barang_model.dart';

void main() {
  runApp(MaterialApp(
    home: BarangGridPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class BarangGridPage extends StatefulWidget {
  @override
  _BarangGridPageState createState() => _BarangGridPageState();
}

class _BarangGridPageState extends State<BarangGridPage> {
  late Future<List<Barang>> listBarang;
  static const String baseImageUrl = "http://172.31.160.1/API/uploads/";

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    setState(() {
      listBarang = ApiService.getBarang();
    });
  }

  void deleteBarang(String kdBrg) async {
    try {
      // PERUBAHAN: ApiService.deleteBarang() sekarang mengembalikan Map
      Map<String, dynamic> result = await ApiService.deleteBarang(kdBrg);

      if (result["success"]) {
        refresh();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"] ?? "Berhasil dihapus"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"] ?? "Gagal menghapus"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmDelete(BuildContext context, Barang barang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Hapus ${barang.nmBrg}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteBarang(barang.kdBrg);
            },
            child: Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Katalog Barang"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormBarang(refresh: refresh),
            ),
          ).then((_) => refresh());
        },
      ),
      body: FutureBuilder<List<Barang>>(
        future: listBarang,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Memuat data..."),
                ],
              ),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 64),
                  SizedBox(height: 16),
                  Text("Error: ${snapshot.error}"),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: refresh,
                    child: Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          }

          // Data loaded but empty
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Belum ada data barang"),
                  SizedBox(height: 8),
                  Text("Tekan + untuk menambah"),
                ],
              ),
            );
          }

          // Data loaded successfully
          List<Barang> data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                Barang brg = data[index];
                // 🔍 Tambahkan baris ini
                print("URL IMAGE = $baseImageUrl${brg.gambar}");
                print("IMAGE: ${brg.gambar}");
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      // Optional: Add detail view
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              color: Colors.grey[100],
                            ),
                            child: brg.gambar != null && brg.gambar!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      "$baseImageUrl${brg.gambar}",
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                        child: Icon(Icons.broken_image,
                                            size: 50, color: Colors.grey),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                brg.nmBrg,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Satuan: ${brg.satuan ?? '-'}",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Harga: ${_formatCurrency(brg.harga)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Stok: ${brg.stok} ${brg.satuan ?? ''}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue[700],
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FormBarang(
                                            barang: brg,
                                            refresh: refresh,
                                          ),
                                        ),
                                      ).then((_) => refresh());
                                    },
                                    iconSize: 20,
                                    tooltip: "Edit",
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        _confirmDelete(context, brg),
                                    iconSize: 20,
                                    tooltip: "Hapus",
                                  ),
                                ],
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
          );
        },
      ),
    );
  }

  String _formatCurrency(dynamic value) {
    try {
      if (value == null) return "Rp 0";

      // Handle jika value adalah String
      double amount;
      if (value is String) {
        amount = double.tryParse(value) ?? 0;
      } else if (value is int) {
        amount = value.toDouble();
      } else if (value is double) {
        amount = value;
      } else {
        amount = 0;
      }

      // Format dengan 2 decimal places untuk harga
      String formatted = amount.toStringAsFixed(2);

      // Tambahkan pemisah ribuan
      List<String> parts = formatted.split('.');
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : "00";

      String integerWithSeparator = integerPart.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );

      return "Rp $integerWithSeparator,$decimalPart";
    } catch (e) {
      return "Rp 0";
    }
  }
}
