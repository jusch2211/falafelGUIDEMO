import 'package:flutter/material.dart';

class FalafelCard extends StatelessWidget {
  final Map<String, dynamic> falafel;
  final bool isAdmin;
  final VoidCallback? onDelete;

  const FalafelCard({
    required this.falafel,
    required this.isAdmin,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(falafel['name']),
        subtitle: Text('ID: ${falafel['id']}'),
        trailing: isAdmin
            ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}
