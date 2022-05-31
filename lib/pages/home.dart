import 'package:ez_split/pages/totals.dart';
import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/app_bar.dart';
import 'package:ez_split/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalProvider).value;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Wrap(
            children:  [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InfoCard(
                    label: "People Orders",
                    providerToWatch: peopleProvider,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InfoCard(
                    label: "Shared Fees",
                    providerToWatch: feesProvider,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
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
        
      ),
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => const TotalsPage()))),
          child: const Text("Split It!")),
    );
  }
}
