import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/kategori_barang_controller.dart';
import '../model/kategori_barang_model.dart';
import 'kategori_barang.dart';

class AddKategoriBarang extends StatefulWidget {
  const AddKategoriBarang({super.key});

  @override
  State<AddKategoriBarang> createState() => _AddKategoriBarangState();
}

class _AddKategoriBarangState extends State<AddKategoriBarang> {
  final kategoriBarangController = KategoriBarangController();
  String? nama;
  //int? index;

  void addKategoriBarang() async {
    KategoriBarangModel kategoriBarang = KategoriBarangModel(nama: nama!);
    await kategoriBarangController.addKategoriBarang(kategoriBarang);
  }

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kategori Barang'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nama Kategori Barang',
                hintText: 'Nama Kategori Barang',
              ),
              onChanged: (value) {
                nama = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Kategori Diperlukan';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KategoriBarang()));
                  addKategoriBarang();

                  var snackBar =
                      const SnackBar(content: Text('Data Berhasil Disimpan'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
