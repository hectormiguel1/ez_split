import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalCard extends ConsumerWidget {
  const TotalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final people = ref.watch(peopleProvider);
    final sharedFees = ref.watch(feesProvider);
    final paid = ref.watch(paidProvider);
    final tax = ref.watch(taxProvider).value;

    return CustomCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "Total Per Person",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          DataTable(
            columnSpacing: 15,
              columns: const [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Amount \$")),
                DataColumn(label: Text("Paid?")),
                DataColumn(label: Text("Pay"))
              ],
              rows: people.map.entries.map(
                (e) {
                  var personTotal = e.value +
                      (e.value * tax) +
                      (sharedFees.map.entries.fold<double>(
                              0.0,
                              ((previousValue, element) =>
                                  previousValue += element.value))) /
                          people.map.length;
                  return DataRow(cells: [
                    DataCell(
                      Text(e.key),
                    ),
                    DataCell(
                      Text(personTotal.toStringAsFixed(2)),
                    ),
                    DataCell(Text(paid.map[e.key]! ? "Yes" : "No")),
                    DataCell(IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => paid.updateElement(e.key, true),
                    ))
                  ]);
                },
              ).toList()),
        ],
      ),
    );
  }
}
