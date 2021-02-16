import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import './landing.dart';

Future<void> main() async {
				WidgetsFlutterBinding.ensureInitialized();
				await Firebase.initializeApp();
				await sharedPrefs.init();


				runApp(MyApp());
		}
		
		
class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
						home: Landing(),
						);
				}
}

