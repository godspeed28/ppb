import 'package:flutter/material.dart';
import 'barang_model.dart';
import 'service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FormBarang extends StatefulWidget {
  final Barang? barang;
  final Function refresh;

  FormBarang({this.barang, required this.refresh});

  @override
  _FormBarangState createState() => _FormBarangState();
}

class _FormBarangState extends State<FormBarang> {
  final _formKey = GlobalKey<FormState>();
  final kdController = TextEditingController();
  final nmController = TextEditingController();
  final satuanController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();

  File? imageFile; // file gambar baru yg dipilih user
  static const String baseImageUrl = "http://172.31.160.1/API/uploads/";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      kdController.text = widget.barang!.kdBrg;
      nmController.text = widget.barang!.nmBrg;
      satuanController.text = widget.barang!.satuan;
      hargaController.text = widget.barang!.harga;
      stokController.text = widget.barang!.stok;
    }
  }

  @override
  void dispose() {
    kdController.dispose();
    nmController.dispose();
    satuanController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? picked = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 85,
                );
                if (picked != null) {
                  setState(() {
                    imageFile = File(picked.path);
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? picked = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 85,
                );
                if (picked != null) {
                  setState(() {
                    imageFile = File(picked.path);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAlert(
      BuildContext context, String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Barang brg = Barang(
        kdBrg: kdController.text.trim(),
        nmBrg: nmController.text.trim(),
        satuan: satuanController.text.trim(),
        harga: hargaController.text.trim(),
        stok: stokController.text.trim(),
        gambar: widget.barang?.gambar ?? "",
      );

      bool success = false;

      // Menjadi:
      Map<String, dynamic> result;

      if (widget.barang != null) {
        result = await ApiService.updateBarang(brg, imageFile);
      } else {
        result = await ApiService.addBarang(brg, imageFile);
      }

      if (result["success"]) {
        widget.refresh();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"] ?? "Berhasil!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"] ?? "Gagal menyimpan data"),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (success) {
        widget.refresh();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.barang != null
                ? "Berhasil mengupdate barang!"
                : "Berhasil menambah barang!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        _showAlert(context, "Gagal",
            "Gagal menyimpan data. Periksa koneksi atau server.", false);
      }
    } catch (e) {
      _showAlert(context, "Error", "Terjadi kesalahan: ${e.toString()}", false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.barang != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Barang" : "Tambah Barang"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ==================== KODE BARANG ====================
                    TextFormField(
                      controller: kdController,
                      decoration: InputDecoration(
                        labelText: "Kode Barang",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.code),
                      ),
                      readOnly: isEdit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kode barang harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // ==================== NAMA BARANG ====================
                    TextFormField(
                      controller: nmController,
                      decoration: InputDecoration(
                        labelText: "Nama Barang",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.shopping_bag),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama barang harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // ==================== SATUAN ====================
                    TextFormField(
                      controller: satuanController,
                      decoration: InputDecoration(
                        labelText: "Satuan (Kg, Pcs, Liter, dll)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.scale),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Satuan harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // ==================== HARGA ====================
                    TextFormField(
                      controller: hargaController,
                      decoration: InputDecoration(
                        labelText: "Harga",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga harus diisi';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Harga harus angka yang valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // ==================== STOK ====================
                    TextFormField(
                      controller: stokController,
                      decoration: InputDecoration(
                        labelText: "Stok",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stok harus diisi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Stok harus angka bulat';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),

                    // ==================== GAMBAR ====================
                    Text(
                      "Foto Produk",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tekan untuk memilih foto",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100],
                        ),
                        child: Stack(
                          children: [
                            // Gambar baru yang dipilih
                            if (imageFile != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),

                            // Gambar dari server (jika edit dan belum pilih gambar baru)
                            if (imageFile == null &&
                                widget.barang != null &&
                                widget.barang!.gambar != null &&
                                widget.barang!.gambar!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "$baseImageUrl${widget.barang!.gambar}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
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
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.broken_image,
                                            size: 50, color: Colors.grey),
                                        SizedBox(height: 8),
                                        Text("Gagal memuat gambar",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // Icon default jika tidak ada gambar
                            if (imageFile == null &&
                                (widget.barang == null ||
                                    widget.barang!.gambar == null ||
                                    widget.barang!.gambar!.isEmpty))
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      size: 60,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Tambahkan Foto",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Indikator jika ada gambar
                            if (imageFile != null ||
                                (widget.barang != null &&
                                    widget.barang!.gambar != null &&
                                    widget.barang!.gambar!.isNotEmpty))
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32),

                    // ==================== TOMBOL SIMPAN ====================
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(isEdit ? Icons.update : Icons.save),
                            label: Text(
                                isEdit ? "UPDATE BARANG" : "SIMPAN BARANG"),
                            onPressed: _isLoading ? null : _saveData,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    TextButton(
                      onPressed:
                          _isLoading ? null : () => Navigator.pop(context),
                      child: Text("BATAL"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
