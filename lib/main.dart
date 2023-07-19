import 'package:currency_converter/dependancy_manager.dart';

import 'app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await setUpDependencies();
  runApp(const MyApp());
}
