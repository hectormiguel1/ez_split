import 'package:ez_split/model/notifer_map.dart';
import 'package:ez_split/pages/home.dart';
import 'package:ez_split/provider/providers.dart';
import 'package:ez_split/widgets/app_bar.dart';
import 'package:ez_split/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Templates {
  UberEats("UberEats", ["Delivery", "Service", "Fuel Upchage", "Tip"],
      FaIcon(FontAwesomeIcons.uber)),
  DoorDash("DoorDash", ["Delivery", "Service", "Fuel Upcharge", "Tip"],
      FaIcon(FontAwesomeIcons.dashcube)),
  GrubHub(
      "GrubHub", ["Delivery", "Service", "Tip"], FaIcon(FontAwesomeIcons.car)),
  Restaurant("Restaurant", ["Tip"], Icon(Icons.restaurant)),
  Custom("Custom", [], FaIcon(FontAwesomeIcons.penToSquare));

  final String name;
  final List<String> fees;
  final Widget icon;

  const Templates(this.name, this.fees, this.icon);

  factory Templates.fromString(String name) {
    switch (name) {
      case "UberEats":
        return UberEats;
      case "DoorDash":
        return DoorDash;
      case "GrubHub":
        return GrubHub;
      case "Restaurant":
        return Restaurant;
      case "Custom":
        return Custom;
      default:
        return Custom;
    }
  }

  @override
  String toString() => name;
}

class TemplateSelection extends ConsumerWidget {
  const TemplateSelection({Key? key}) : super(key: key);

  void selectedTemplate(NotifierMap fees, Templates selection) {
    fees.clear();
    for (var fee in selection.fees) {
      fees.addElement(fee, 0.0);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: CustomAppBar(),
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
                ...Templates.values
                    .map((template) => ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: 500, minWidth: 300),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Tooltip(
                              message: "Select ${template.name}",
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                leading: template.icon,
                                title: Text(template.name),
                                trailing: const Icon(Icons.arrow_right),
                                onTap: () {
                                  selectedTemplate(
                                      ref.watch(feesProvider), template);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const DataEntryScreen()));
                                },
                              ),
                            ),
                          ),
                        ))
                    .toList()
              ],
            ))));
  }
}
