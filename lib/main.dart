import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mrpostsboard/app_widget.dart';
import 'firebase_options.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
