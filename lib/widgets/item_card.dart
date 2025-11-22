import 'package:flutter/material.dart';
import '../models/item.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ItemCard(
      {super.key,
      required this.item,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('yyyy-MM-dd HH:mm');
    return Card(
      child: ListTile(
        title: Text(item.title),
        subtitle: Text('${item.description}\n${df.format(item.createdAt)}'),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (v) {
            if (v == 'edit') onEdit();
            if (v == 'del') onDelete();
          },
          itemBuilder: (_) => [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'del', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
