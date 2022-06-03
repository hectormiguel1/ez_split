import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/app_bar.dart';
import 'package:ez_split/widgets/drower.dart';
import 'package:ez_split/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataEntryScreen extends ConsumerWidget {
  const DataEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalProvider).value;
    final theme = ref.watch(appThemeProvider);
    ref.watch(currentRouteProvider).value = ModalRoute.of(context)!.settings.name!;
    theme.updateUI(context);
    return Scaffold(
      appBar: CustomAppBar(subtitle: ref.watch(templateProvider).value.name,),
      endDrawer: theme.shouldUseDrower ? const CustomDrawer() : null,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: InfoCard(
                  label: "Orders",
                  providerToWatch: peopleProvider,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InfoCard(
                  label: "Fees",
                  providerToWatch: feesProvider,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
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
          onPressed: () => Navigator.of(context).pushNamed('total'),
          child: const Text("Split It!")),
    );
  }
}
