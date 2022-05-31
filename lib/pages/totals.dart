import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/app_bar.dart';
import 'package:ez_split/widgets/total_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalsPage extends ConsumerWidget {
  const TotalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalProvider).value;
    return Scaffold(
        appBar: CustomAppBar(),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: TotalCard(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Total: \$ ${total.toStringAsFixed(2)}"))),
                ),
              ],
            ),
          ),
        ));
  }
}
