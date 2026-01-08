import 'package:flutter/material.dart';
import '../services/falafel_api.dart';
import '../widgets/falafel_card.dart';

class FalafelScreen extends StatefulWidget {
  final bool isAdmin;

  const FalafelScreen({required this.isAdmin});

  @override
  State<FalafelScreen> createState() => _FalafelScreenState();
}

class _FalafelScreenState extends State<FalafelScreen> {
  final FalafelApi api = FalafelApi();
  List<Map<String, dynamic>> falafel = [];

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFalafel();
  }

  void loadFalafel() async {
    showRestCallDialog('GET', '/falafel');
    falafel = await api.getFalafel();
    setState(() {});
  }

  void addFalafel() async {
    showRestCallDialog('POST', '/falafel');
    final newFalafel = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': nameController.text,
    };

    falafel = await api.addFalafel(falafel, newFalafel);
    nameController.clear();
    setState(() {});
  }

  void deleteFalafel(int id) async {
    showRestCallDialog('DELETE', '/falafel/$id');
    falafel = await api.deleteFalafel(falafel, id);
    setState(() {});
  }

  void editFalafel(Map<String, dynamic> falafelItem) {
    final controller = TextEditingController(text: falafelItem['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Falafel bearbeiten'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Falafel Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              showRestCallDialog(
                'PUT',
                '/falafel/${falafelItem['id']}',
              );

              setState(() {
                falafel = falafel.map((f) {
                  if (f['id'] == falafelItem['id']) {
                    return {
                      ...f,
                      'name': controller.text,
                    };
                  }
                  return f;
                }).toList();
              });

              Navigator.pop(context);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }

  void showRestCallDialog(String method, String endpoint) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('REST Call'),
        content: Text(
          '$method $endpoint',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isAdmin)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'Falafel Name'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addFalafel,
                  child: const Text('Hinzufügen'),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView(
            children: falafel.map((f) {
              return FalafelCard(
                falafel: f,
                isAdmin: widget.isAdmin,
                onDelete: () => deleteFalafel(f['id']),
                onEdit: widget.isAdmin ? () => editFalafel(f) : null,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
