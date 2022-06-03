import 'package:ez_split/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaxDialog extends ConsumerWidget {
  final TextEditingController _taxController = TextEditingController();

  TaxDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tax = ref.watch(taxProvider);
    _taxController.text = tax.value.toStringAsFixed(2);
    return AlertDialog(
        title: const Text("Update Tax %"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: _taxController,
                  decoration: InputDecoration(
                      label: const Text("Enter Tax %"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      child: const Text("Save"),
                      onPressed: () {
                        var parsedValue =
                            double.tryParse(_taxController.text) ?? 0.0;
                        tax.value = parsedValue > 1.0
                            ? (parsedValue / 100)
                            : parsedValue;
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ))
          ],
        ));
  }
}
