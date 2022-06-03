import 'package:ez_split/pages/home.dart';
import 'package:ez_split/pages/template.dart';
import 'package:ez_split/pages/totals.dart';
import 'package:flutter/material.dart';

final routes = {
  "/":  (BuildContext ctx) => const TemplateSelection(),
  "data": (BuildContext ctx) => const DataEntryScreen(),
  "total": (BuildContext ctx) => const TotalsPage()
};

final routeFromType = {
  TemplateSelection:  "/",
  DataEntryScreen : "data",
  TotalsPage : "total"
};