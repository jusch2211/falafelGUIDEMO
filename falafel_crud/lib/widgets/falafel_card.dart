import 'package:flutter/material.dart';

class FalafelCard extends StatelessWidget {
  final Map<String, dynamic> falafel;
  final bool isAdmin;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const FalafelCard({
    required this.falafel,
    required this.isAdmin,
    this.onDelete,
    this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(falafel['name']),
        subtitle: Text('ID: ${falafel['id']}'),
        trailing: isAdmin
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Bearbeiten',
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Löschen',
                    onPressed: onDelete,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
