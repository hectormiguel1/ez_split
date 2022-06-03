import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/color_picker.dart';
import 'package:ez_split/widgets/tax_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tax = ref.watch(taxProvider).value;
    final theme = ref.watch(appThemeProvider);

    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListView(padding: EdgeInsets.zero, children: [
      const DrawerHeader(child: Align(alignment: Alignment.center, child: Text("EZ Split Settings")),),
      
      ListTile(
        title: const Text("Current Color Theme: "),
        trailing: Icon(Icons.circle, color: theme.colorTheme),
        onTap: () => showDialog(context: context, builder: (_) => const ColorPicker())
      ),
      ListTile(
        title: const Text("Toggle Dark Mode"),
        trailing: const Icon(Icons.dark_mode),
        onTap: () => theme.toggleBrightness(),
      )
    ]));
  }
}
