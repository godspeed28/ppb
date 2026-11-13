import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiver/core.dart' show hashValues, hashList;

// Tambahkan di atas file FormPage.dart
class FormPage extends StatefulWidget {
  // Constructor memiliki satu parameter opsional
  // Jika memiliki id, akan menampilkan data dan menjalankan metode update
  // Jika tidak, akan menjalankan add data
  const FormPage({this.id});
  final String? id;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text editing controller variables
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();

  // Initialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? users;

  void getData() async {
    // Get users collection from firebase
    // Collection adalah tabel dalam MySQL
    users = firebase.collection('users');

    // Jika memiliki id
    if (widget.id != null) {
      // Get users data berdasarkan id document
      var data = await users!.doc(widget.id).get();

      // Kita mendapatkan data.data()
      // Agar dapat diakses, kita buat sebagai Map
      var item = data.data() as Map<String, dynamic>;

      // Set state untuk mengisi controller dari data firebase
      setState(() {
        nameController = TextEditingController(text: item['name']);
        phoneNumberController = TextEditingController(
          text: item['phoneNumber'],
        );
        emailController = TextEditingController(text: item['email']);
        addressController = TextEditingController(text: item['address']);
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTACT FORM"),
        actions: [
          // Jika memiliki data, tampilkan tombol delete
          widget.id != null
              ? IconButton(
                  onPressed: () {
                    // Method untuk menghapus data berdasarkan id
                    users!.doc(widget.id).delete();
                    // Kembali ke halaman utama
                    // '/' adalah home
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.delete),
                )
              : const SizedBox(),
        ],
      ),
      // Form untuk menambah dan mengedit data
      // Jika memiliki id yang dikirim dari main, field akan menampilkan data
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 10),
            const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
            const SizedBox(height: 20),
            // Name Field
            Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is Required!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Phone Number Field
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone Number is Required!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Email Field
            Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is Required!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Address Field
            Text(
              'Address',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address is Required!';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Jika id null, jalankan add data untuk menyimpan data ke firebase
                  // Jika tidak, update data berdasarkan id
                  if (widget.id == null) {
                    users!.add({
                      'name': nameController.text,
                      'phoneNumber': phoneNumberController.text,
                      'email': emailController.text,
                      'address': addressController.text,
                    });
                  } else {
                    users!.doc(widget.id).update({
                      'name': nameController.text,
                      'phoneNumber': phoneNumberController.text,
                      'email': emailController.text,
                      'address': addressController.text,
                    });
                  }

                  // Snackbar notification
                  final snackBar = const SnackBar(
                    content: Text('Data saved successfully!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // Kembali ke halaman utama
                  // Home page => '/'
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
