import 'package:ez_split/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorPicker extends ConsumerWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return AlertDialog(
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
                                icon: Icon(Icons.circle, color: color),
                                onPressed: () => theme.colorTheme = color),
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
        ));
  }
}
