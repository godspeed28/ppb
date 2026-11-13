import 'package:flutter/material.dart';
import '../models/user.dart';
import 'barang_list_page.dart';
import 'login_page.dart';

class MenuPage extends StatelessWidget {
  final User user;
  const MenuPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat datang, ${user.fullname}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            tooltip: 'Logout',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BarangListPage())),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child:
                        Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.inventory_2, size: 36),
                  SizedBox(height: 8),
                  Text('Kelola Barang',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ])),
              ),
            ),
            // add cards for other features if needed
          ],
        ),
      ),
    );
  }
}
