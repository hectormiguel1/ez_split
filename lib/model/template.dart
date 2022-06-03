import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Template {
  Unselected("Unselected", [], Icon(Icons.stop_circle)),
  UberEats("UberEats", ["Delivery", "Service", "Fuel Upcharge", "Tip"],
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

  const Template(this.name, this.fees, this.icon);

  factory Template.fromString(String name) {
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
