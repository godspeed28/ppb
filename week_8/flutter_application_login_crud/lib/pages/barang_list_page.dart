import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/barang.dart';
import 'barang_form_page.dart';

class BarangListPage extends StatefulWidget {
  const BarangListPage({super.key});
  @override
  State<BarangListPage> createState() => _BarangListPageState();
}

class _BarangListPageState extends State<BarangListPage> {
  final DbHelper _db = DbHelper();
  List<Barang> _list = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _db.getAllBarang();
    setState(() => _list = data);
  }

  Future<void> _delete(Barang b) async {
    await _db.deleteBarang(b.id!);
    _load();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data dihapus')));
  }

  void _openForm({Barang? barang}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => BarangFormPage(barang: barang)));
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
      ),
      body: _list.isEmpty
          ? const Center(child: Text('Belum ada data barang'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _list.length,
              itemBuilder: (context, i) {
                final b = _list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                        child: Text(b.kdBrg.replaceAll(RegExp(r'[^0-9]'), ''))),
                    title: Text('${b.kdBrg} — ${b.nmBrg}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text('Harga Beli: ${b.hrgBeli}'),
                          Text('Harga Jual: ${b.hrgJual}'),
                          Text('Stok: ${b.stok}'),
                        ]),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openForm(barang: b)),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: Text('Hapus ${b.nmBrg}?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Batal')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _delete(b);
                                            },
                                            child: const Text('Hapus')),
                                      ],
                                    ));
                          }),
                    ]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openForm(),
      ),
    );
  }
}
