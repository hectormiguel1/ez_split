import 'package:ez_split/model/notifer_map.dart';
import 'package:ez_split/widgets/custom_card.dart';
import 'package:ez_split/widgets/input_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoCard extends ConsumerWidget {
  final AutoDisposeChangeNotifierProvider<NotifierMap<String, double>>
      providerToWatch;
  final String label;

  const InfoCard(
      {required this.providerToWatch, required this.label, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final observableDS = ref.watch(providerToWatch);
    return CustomCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Tooltip(
                    message: "Clear all Entries on $label",
                    child: TextButton(
                      child: const Text("Clear"),
                      onPressed: () => observableDS.clear(),
                    ),
                  ),
                )
              ],
            ),
          ),
          DataTable(
              columnSpacing: 15,
              columns: const [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Amount \$")),
                DataColumn(label: Text("Actions"))
              ],
              rows: observableDS.map.entries
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.key),
                        ),
                        DataCell(Text(e.value.toStringAsFixed(2)),
                            showEditIcon: true,
                            onTap: () => showDialog(
                                context: context,
                                builder: (_) => InputCard(
                                      provider: providerToWatch,
                                      label: label,
                                      editKey: e.key,
                                    ))),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.remove, color: Colors.red),
                                onPressed: () => observableDS.remove(e.key),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList()),
          const SizedBox(
            height: 5,
          ),
          Tooltip(
            message: "Add new $label",
            child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => showDialog(
                      context: context,
                      builder: (_) => InputCard(
                        label: label,
                        provider: providerToWatch,
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
