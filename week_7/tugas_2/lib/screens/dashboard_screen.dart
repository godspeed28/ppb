import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../services/shared_prefs_service.dart';
import 'product_detail_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _logout(BuildContext context) async {
    await SharedPrefsService.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  Image.network(product.image, height: 100, fit: BoxFit.cover),
                  const SizedBox(height: 8),
                  Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Rp ${product.price.toStringAsFixed(0)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
