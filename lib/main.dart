import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ggd_ggdmart/constant/colors.dart';
import 'package:ggd_ggdmart/constant/styles.dart';
import 'package:ggd_ggdmart/views/auth_screen/login_screen.dart';
import 'package:ggd_ggdmart/views/home_screen/home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBexo0Ge9l_8y958uSPMVF-gnDeHGpsEmY", 
      appId: "1:528228304793:android:221b1d151afc25900fb508", 
      messagingSenderId: "528228304793", 
      projectId: "ggd-mart",
      storageBucket: "ggd-mart.appspot.com",
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;
  chekIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    chekIfLogin();
    super.initState();
  }

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: darkFontGrey),
              backgroundColor: Colors.transparent),
          fontFamily: regular),
      home: isLogin ? const Home() : const LoginScreen(),
    );
  }
}
