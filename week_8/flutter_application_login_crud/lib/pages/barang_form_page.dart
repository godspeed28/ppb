import 'package:flutter/material.dart';
import '../models/barang.dart';
import '../db/db_helper.dart';

class BarangFormPage extends StatefulWidget {
  final Barang? barang;
  const BarangFormPage({super.key, this.barang});

  @override
  State<BarangFormPage> createState() => _BarangFormPageState();
}

class _BarangFormPageState extends State<BarangFormPage> {
  final _kd = TextEditingController();
  final _nm = TextEditingController();
  final _beli = TextEditingController();
  final _jual = TextEditingController();
  final _stok = TextEditingController();
  final _db = DbHelper();

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      final b = widget.barang!;
      _kd.text = b.kdBrg;
      _nm.text = b.nmBrg;
      _beli.text = b.hrgBeli.toString();
      _jual.text = b.hrgJual.toString();
      _stok.text = b.stok.toString();
    }
  }

  void _save() async {
    final kd = _kd.text.trim();
    final nm = _nm.text.trim();
    final beli = int.tryParse(_beli.text) ?? 0;
    final jual = int.tryParse(_jual.text) ?? 0;
    final stok = int.tryParse(_stok.text) ?? 0;

    if (kd.isEmpty || nm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kode & Nama barang wajib diisi')));
      return;
    }

    final barang = Barang(
      id: widget.barang?.id,
      kdBrg: kd,
      nmBrg: nm,
      hrgBeli: beli,
      hrgJual: jual,
      stok: stok,
    );

    if (widget.barang == null) {
      await _db.insertBarang(barang);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Barang ditambahkan')));
    } else {
      await _db.updateBarang(barang);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Barang diupdate')));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.barang != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Barang' : 'Tambah Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                  controller: _kd,
                  decoration:
                      const InputDecoration(labelText: 'Kode Barang (KdBrg)')),
              const SizedBox(height: 8),
              TextField(
                  controller: _nm,
                  decoration:
                      const InputDecoration(labelText: 'Nama Barang (NmBrg)')),
              const SizedBox(height: 8),
              TextField(
                  controller: _beli,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Harga Beli')),
              const SizedBox(height: 8),
              TextField(
                  controller: _jual,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Harga Jual')),
              const SizedBox(height: 8),
              TextField(
                  controller: _stok,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Stok')),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: _save,
                        child: Text(isEdit ? 'Update' : 'Save'))),
                const SizedBox(width: 12),
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'))),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
