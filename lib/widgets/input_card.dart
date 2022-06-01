import 'package:ez_split/model/notifer_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class InputCard extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final AutoDisposeChangeNotifierProvider<NotifierMap<String, double>> provider;
  final String label;
  final String? editKey;
  InputCard(
      {super.key, required this.provider, required this.label, this.editKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notiferDS = ref.watch(provider);
    if (editKey != null) {
      _nameController.text = editKey!;
      _amountController.text = notiferDS.map[editKey].toString();
    }

    return AlertDialog(
      title: Text(editKey != null ? "Edit $label" : "Add new $label"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text("Enter $label Name:"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: _amountController,
              decoration: InputDecoration(
                label: Text("Enter $label Amount:"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 10),
        TextButton(
          child: const Text("Enter"),
          onPressed: () {
            var name = _nameController.text;
            var amount = double.tryParse(_amountController.text) ?? 0.0;
            notiferDS.addElement(name, amount);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
