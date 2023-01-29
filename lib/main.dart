import 'package:flutter/material.dart';
import 'package:maps_challenge/app/app_widget.dart';
import 'package:maps_challenge/app/injections.dart';

void main() {
  Injections.registerInjections();
  runApp(const AppWidget());
}
