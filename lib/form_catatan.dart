import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/catatan.dart';

class FormCatatan extends StatefulWidget {
  final Catatan? catatan;
  final Function refresh;

  const FormCatatan({super.key, this.catatan, required this.refresh});

  @override
  State<FormCatatan> createState() => _FormCatatanState();
}

class _FormCatatanState extends State<FormCatatan> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();
  final DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    if (widget.catatan != null) {
      _judulController.text = widget.catatan!.judul;
      _isiController.text = widget.catatan!.isi;
    }
  }

  void _simpanCatatan() async {
    if (_formKey.currentState!.validate()) {
      Catatan catatan = Catatan(
        id: widget.catatan?.id,
        judul: _judulController.text,
        isi: _isiController.text,
      );

      if (widget.catatan == null) {
        await _dbHelper.insertCatatan(catatan);
      } else {
        await _dbHelper.updateCatatan(catatan);
      }

      widget.refresh();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: "Judul"),
                validator: (value) => value!.isEmpty ? "Masukkan judul" : null,
              ),
              TextFormField(
                controller: _isiController,
                decoration: const InputDecoration(labelText: "Isi Catatan"),
                maxLines: 4,
                validator: (value) => value!.isEmpty ? "Masukkan isi" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpanCatatan,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}