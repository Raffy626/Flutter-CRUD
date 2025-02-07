import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/catatan.dart';
import 'form_catatan.dart';

class ListCatatan extends StatefulWidget {
  const ListCatatan({super.key});

  @override
  State<ListCatatan> createState() => _ListCatatanState();
}

class _ListCatatanState extends State<ListCatatan> {
  final DbHelper _dbHelper = DbHelper();
  List<Catatan> _catatanList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<Catatan> data = await _dbHelper.getCatatan();
    setState(() {
      _catatanList = data;
    });
  }

  void _hapusCatatan(int id) async {
    await _dbHelper.deleteCatatan(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buku Catatan")),
      body: ListView.builder(
        itemCount: _catatanList.length,
        itemBuilder: (context, index) {
          final catatan = _catatanList[index];
          return ListTile(
            title: Text(catatan.judul),
            subtitle: Text(catatan.isi),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _hapusCatatan(catatan.id!),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormCatatan(catatan: catatan, refresh: _loadData),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormCatatan(refresh: _loadData),
          ),
        ),
      ),
    );
  }
}
