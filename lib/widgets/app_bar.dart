import 'package:ez_split/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget with PreferredSizeWidget {
  final TextEditingController _taxController = TextEditingController();
  CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final tax = ref.watch(taxProvider);
    _taxController.text = tax.value.toStringAsFixed(2);
    return AppBar(
      title: const Text("EZ Split"),
      actions: [
        Tooltip(
          message: "Current Tax Rate, Click to Change",
          child: TextButton(
            child: Text("Tax: ${(tax.value * 100).toStringAsFixed(2)} %"),
            onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
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
                                      borderRadius:
                                          BorderRadius.circular(20)))),
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
                                    var parsedValue = double.tryParse(_taxController.text) ?? 0.0;
                                    tax.value = parsedValue > 1.0 ? (parsedValue / 100) : parsedValue;
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ))
                      ],
                    ))),
          ),
        ),
        Tooltip(
          message: "Change Application Color Theme",
          child: IconButton(
            icon: Icon(Icons.circle, color: theme.colorTheme),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      title: const Text("Pick Color Theme"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            children: Colors.primaries
                                .map((color) => SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.circle,
                                                  color: color),
                                              onPressed: () =>
                                                  theme.colorTheme = color),
                                          color == theme.colorTheme
                                              ? const Icon(Icons.check)
                                              : Container()
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            child: const Text("Done"),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      )));
            },
          ),
        ),
        Tooltip(
          message: "Toggle Dark Mode",
          child: IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => theme.toggleBrightness(),
          ),
        ),
        Tooltip(
          message: "Use Material 3 Widgets?",
          child: Switch(
            activeColor: theme.colorTheme,
            value: theme.useMaterial3,
            onChanged: (value) => theme.toggleMaterial3(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
