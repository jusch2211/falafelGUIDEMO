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
    falafel = await api.getFalafel();
    setState(() {});
  }

  void addFalafel() async {
    final newFalafel = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': nameController.text,
    };

    falafel = await api.addFalafel(falafel, newFalafel);
    nameController.clear();
    setState(() {});
  }

  void deleteFalafel(int id) async {
    falafel = await api.deleteFalafel(falafel, id);
    setState(() {});
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
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
