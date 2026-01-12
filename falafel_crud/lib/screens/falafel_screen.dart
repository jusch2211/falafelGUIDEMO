import 'package:flutter/material.dart';
import '../services/falafel_repository.dart';
import '../services/falafel_service_factory.dart';

class FalafelScreen extends StatefulWidget {
  final bool isAdmin;

  const FalafelScreen({super.key, required this.isAdmin});

  @override
  State<FalafelScreen> createState() => _FalafelScreenState();
}

class _FalafelScreenState extends State<FalafelScreen> {
  late FalafelRepository api;
  List<Map<String, dynamic>> falafel = [];

  @override
  void initState() {
    super.initState();
    api = FalafelServiceFactory.create();
  }

  // -------- REST Simulation Dialog --------
  void showRestCallDialog(String method, String path) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('REST Call'),
        content: Text('$method $path'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  // -------- Load Falafel --------
  Future<void> loadFalafel() async {
    showRestCallDialog('GET', '/falafel');
    falafel = await api.getFalafel();
    setState(() {});
  }

  // -------- Add Falafel --------
  Future<void> addFalafel() async {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Falafel erstellen'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newFalafel = {
                'id': DateTime.now().millisecondsSinceEpoch,
                'name': controller.text,
              };

              showRestCallDialog('POST', '/falafel');
              await api.addFalafel(newFalafel);
              await loadFalafel();

              if (mounted) Navigator.pop(context);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }

  // -------- Edit Falafel --------
  Future<void> editFalafel(Map<String, dynamic> item) async {
    final controller = TextEditingController(text: item['name']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Falafel bearbeiten'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updated = {
                'id': item['id'],
                'name': controller.text,
              };

              showRestCallDialog('PUT', '/falafel/${item['id']}');
              await api.updateFalafel(item['id'], updated);
              await loadFalafel();

              if (mounted) Navigator.pop(context);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }

  // -------- Delete Falafel --------
  Future<void> deleteFalafel(int id) async {
    showRestCallDialog('DELETE', '/falafel/$id');
    await api.deleteFalafel(id);
    await loadFalafel();
  }

  // -------- UI --------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: loadFalafel,
                icon: const Icon(Icons.refresh),
                label: const Text('Falafel anzeigen'),
              ),
              const SizedBox(width: 16),
              if (widget.isAdmin)
                ElevatedButton.icon(
                  onPressed: addFalafel,
                  icon: const Icon(Icons.add),
                  label: const Text('Falafel erstellen'),
                ),
            ],
          ),
        ),
        Expanded(
          child: falafel.isEmpty
              ? const Center(child: Text('Keine Falafel geladen'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3,
                  ),
                  itemCount: falafel.length,
                  itemBuilder: (_, index) {
                    final item = falafel[index];

                    return Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['name'],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (widget.isAdmin)
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => editFalafel(item),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => deleteFalafel(item['id']),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
