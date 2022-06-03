import 'package:ez_split/model/notifer_map.dart';
import 'package:ez_split/model/template.dart';
import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/app_bar.dart';
import 'package:ez_split/widgets/custom_card.dart';
import 'package:ez_split/widgets/drower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateSelection extends ConsumerWidget {

  const TemplateSelection({Key? key}) : super(key: key);

  void selectedTemplate(NotifierMap fees, Template selection) {
    fees.clear();
    for (var fee in selection.fees) {
      fees.addElement(fee, 0.0);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final templateNotifier = ref.watch(templateProvider);
    ref.watch(currentRouteProvider).value = ModalRoute.of(context)!.settings.name!;
    theme.updateUI(context);
    return Scaffold(
        appBar: CustomAppBar(),
        endDrawer: theme.shouldUseDrower ? const CustomDrawer() : null,
        body: Align(
            alignment: Alignment.topCenter,
            child: CustomCard(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Pick from one the Templates or Select Custom",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                for (Template template in Template.values)
                  if (template != Template.Unselected)
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 500, minWidth: 200),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Tooltip(
                            message: "Select ${template.name}",
                            child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                leading: template.icon,
                                title: Text(template.name),
                                onTap: () {
                                  selectedTemplate(
                                      ref.watch(feesProvider), template);
                                  templateNotifier.value = template;
                                  Navigator.of(context).pushNamed('data');
                                })),
                      ),
                    )
              ],
            ))));
  }
}
