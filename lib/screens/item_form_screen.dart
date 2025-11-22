import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/storage_service.dart';

class ItemFormScreen extends StatefulWidget {
  final Item? item;
  const ItemFormScreen({super.key, this.item});

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _title = TextEditingController();
  final _desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _title.text = widget.item!.title;
      _desc.text = widget.item!.description;
    }
  }

  void _save() async {
    final t = _title.text.trim();
    final d = _desc.text.trim();
    if (t.isEmpty) return;
    if (widget.item == null) {
      await StorageService.addItem(t, d);
    } else {
      final updated = Item(
        id: widget.item!.id,
        title: t,
        description: d,
        createdAt: widget.item!.createdAt,
      );
      await StorageService.updateItem(updated);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Item' : 'Tambah Item')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _title,
                decoration: InputDecoration(labelText: 'Judul')),
            TextField(
                controller: _desc,
                decoration: InputDecoration(labelText: 'Deskripsi')),
            SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: Text('Simpan')),
          ],
        ),
      ),
    );
  }
}
