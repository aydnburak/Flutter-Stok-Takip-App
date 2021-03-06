import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/landing_page.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => UrunViewModel()),
        ChangeNotifierProvider(create: (context) => IslemViewModel()),
      ],
      child: MaterialApp(
        title: 'Stok Yönetimi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.white54,
          buttonColor: Colors.green.shade800,
        ),
        home: LandingPage(),
      ),
    );
  }
}
