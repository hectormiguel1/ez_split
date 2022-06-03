import 'package:ez_split/model/routes.dart';
import 'package:ez_split/pages/template.dart';
import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/color_picker.dart';
import 'package:ez_split/widgets/tax_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget with PreferredSizeWidget {
  final String? subtitle;
  CustomAppBar({Key? key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final tax = ref.watch(taxProvider);
    final currentRoute = ref.watch(currentRouteProvider);
    theme.updateUI(context);
    return AppBar(
      leading: currentRoute.value != routeFromType[TemplateSelection]
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("EZ-Split"),
          subtitle != null
              ? Text(
                  subtitle!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                )
              : Container()
        ],
      ),
      centerTitle: false,
      actions: [
        if (theme.shouldUseDrower) ...[
          Tooltip(
            message: "Current Tax Rate, Click to Change",
            child: TextButton(
              child: Text("Tax: ${(tax.value * 100).toStringAsFixed(2)} %"),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => TaxDialog(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ] else ...[
          Tooltip(
              message: "Current Tax Rate, Click to Change",
              child: TextButton(
                child: Text("Tax: ${(tax.value * 100).toStringAsFixed(2)} %"),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => TaxDialog(),
                ),
              )),
          Tooltip(
            message: "Change Application Color Theme",
            child: IconButton(
                icon: Icon(Icons.circle, color: theme.colorTheme),
                onPressed: () => showDialog(
                    context: context, builder: (_) => const ColorPicker())),
          ),
          Tooltip(
            message: "Toggle Dark Mode",
            child: IconButton(
              icon: const Icon(Icons.dark_mode),
              onPressed: () => theme.toggleBrightness(),
            ),
          ),
        ]
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
