import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/storage_service.dart';
import 'item_form_screen.dart';
import '../widgets/item_card.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Item> items = [];

  void load() {
    items = StorageService.loadItems();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> _refresh() async {
    load();
  }

  void _add() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ItemFormScreen()))
        .then((_) => load());
  }

  void _edit(Item item) {
    Navigator.push(context,
            MaterialPageRoute(builder: (_) => ItemFormScreen(item: item)))
        .then((_) => load());
  }

  void _delete(String id) async {
    await StorageService.deleteItem(id);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: items.isEmpty
              ? Center(child: Text('Belum ada data. Tekan + untuk menambah.'))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final it = items[i];
                    return ItemCard(
                      item: it,
                      onEdit: () => _edit(it),
                      onDelete: () => _delete(it.id),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: Icon(Icons.add),
      ),
    );
  }
}
