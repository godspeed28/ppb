import 'dart:convert';
import 'dart:io'; // <-- WAJIB !!! (untuk File)
import 'package:http/http.dart' as http;
import 'barang_model.dart';

class ApiService {
  static const String baseUrl = "http://localhost/API/";

  // Helper untuk menangani response error
  static Map<String, dynamic> _handleResponse(String responseBody) {
    try {
      return json.decode(responseBody);
    } catch (e) {
      print("JSON Decode Error: $e");
      return {"success": false, "message": "Format response tidak valid"};
    }
  }

  // GET ALL BARANG
  static Future<List<Barang>> getBarang() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}get_barang.php"),
        headers: {'Accept': 'application/json'},
      ).timeout(Duration(seconds: 30));

      print("=== GET BARANG ===");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        try {
          List<dynamic> data = json.decode(response.body);
          return data.map((e) => Barang.fromJson(e)).toList();
        } catch (e) {
          print("JSON Decode Error: $e");
          return [];
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Network Error: $e");
      return [];
    }
  }

  // ADD BARANG DENGAN UPLOAD FILE
  static Future<Map<String, dynamic>> addBarang(
      Barang brg, File? imageFile) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("${baseUrl}add_barang.php"));

      // Tambahkan headers jika diperlukan
      request.headers['Accept'] = 'application/json';

      // Tambahkan field text
      request.fields['kd_brg'] = brg.kdBrg;
      request.fields['nm_brg'] = brg.nmBrg;
      request.fields['satuan'] = brg.satuan;
      request.fields['harga'] = brg.harga;
      request.fields['stok'] = brg.stok;

      // Tambahkan file jika ada
      if (imageFile != null && await imageFile.exists()) {
        request.files.add(await http.MultipartFile.fromPath(
          "gambar", // Perhatikan nama field ini harus sesuai dengan API
          imageFile.path,
          filename: '${brg.kdBrg}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ));
      }

      print("=== ADD BARANG REQUEST ===");
      print("Fields: ${request.fields}");
      print("Files: ${request.files.length}");

      // Kirim request dengan timeout
      var streamedResponse =
          await request.send().timeout(Duration(seconds: 60));
      var response = await http.Response.fromStream(streamedResponse);

      print("=== ADD BARANG RESPONSE ===");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      Map<String, dynamic> result = _handleResponse(response.body);

      if (response.statusCode == 200) {
        return {
          "success": result["success"] == true || result["status"] == "success",
          "message": result["message"] ??
              (result["success"] == true
                  ? "Berhasil menyimpan data"
                  : "Gagal menyimpan data"),
          "data": result
        };
      } else {
        return {
          "success": false,
          "message": "HTTP Error ${response.statusCode}",
          "data": result
        };
      }
    } catch (e) {
      print("Add Barang Error: $e");
      return {"success": false, "message": "Error: $e", "data": {}};
    }
  }

  // UPDATE BARANG + UPLOAD FILE (OPSI)
  static Future<Map<String, dynamic>> updateBarang(
      Barang brg, File? imageFile) async {
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("${baseUrl}update_barang.php"));

      // Tambahkan headers jika diperlukan
      request.headers['Accept'] = 'application/json';

      // Tambahkan field text
      request.fields['kd_brg'] = brg.kdBrg;
      request.fields['nm_brg'] = brg.nmBrg;
      request.fields['satuan'] = brg.satuan;
      request.fields['harga'] = brg.harga;
      request.fields['stok'] = brg.stok;

      // PERHATIAN: Sesuaikan dengan field di API Anda
      // Jika API mengharapkan 'old_gambar' bukan 'old_image'
      if (brg.gambar != null && brg.gambar!.isNotEmpty) {
        request.fields['old_gambar'] = brg.gambar!; // field gambar lama
      }

      // Tambahkan file jika ada
      if (imageFile != null && await imageFile.exists()) {
        request.files.add(await http.MultipartFile.fromPath(
          "gambar", // Perhatikan nama field ini harus sesuai dengan API
          imageFile.path,
          filename: '${brg.kdBrg}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ));
      }

      print("=== UPDATE BARANG REQUEST ===");
      print("Fields: ${request.fields}");
      print("Files: ${request.files.length}");

      // Kirim request dengan timeout
      var streamedResponse =
          await request.send().timeout(Duration(seconds: 60));
      var response = await http.Response.fromStream(streamedResponse);

      print("=== UPDATE BARANG RESPONSE ===");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      Map<String, dynamic> result = _handleResponse(response.body);

      if (response.statusCode == 200) {
        return {
          "success": result["success"] == true || result["status"] == "success",
          "message": result["message"] ??
              (result["success"] == true
                  ? "Berhasil update data"
                  : "Gagal update data"),
          "data": result
        };
      } else {
        return {
          "success": false,
          "message": "HTTP Error ${response.statusCode}",
          "data": result
        };
      }
    } catch (e) {
      print("Update Barang Error: $e");
      return {"success": false, "message": "Error: $e", "data": {}};
    }
  }

  // DELETE BARANG
  static Future<Map<String, dynamic>> deleteBarang(String kdBrg) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}delete_barang.php"),
        body: {
          'kd_brg': kdBrg,
        },
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ).timeout(Duration(seconds: 30));

      print("=== DELETE BARANG ===");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      Map<String, dynamic> result = _handleResponse(response.body);

      if (response.statusCode == 200) {
        return {
          "success": result["success"] == true || result["status"] == "success",
          "message": result["message"] ??
              (result["success"] == true
                  ? "Berhasil menghapus data"
                  : "Gagal menghapus data"),
          "data": result
        };
      } else {
        return {
          "success": false,
          "message": "HTTP Error ${response.statusCode}",
          "data": result
        };
      }
    } catch (e) {
      print("Delete Barang Error: $e");
      return {"success": false, "message": "Error: $e", "data": {}};
    }
  }
}
