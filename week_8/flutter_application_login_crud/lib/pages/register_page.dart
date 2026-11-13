import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _db = DbHelper();

  void _register() async {
    final name = _name.text.trim();
    final username = _username.text.trim();
    final pass = _password.text;
    if (name.isEmpty || username.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semua field wajib diisi')));
      return;
    }
    final exists = await _db.usernameExists(username);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username sudah terpakai')));
      return;
    }
    final user = User(fullname: name, username: username, password: pass);
    await _db.insertUser(user);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap')),
              const SizedBox(height: 8),
              TextField(
                  controller: _username,
                  decoration: const InputDecoration(labelText: 'Username')),
              const SizedBox(height: 8),
              TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password')),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: _register, child: const Text('Submit'))),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
