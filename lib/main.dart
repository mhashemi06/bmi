import 'package:bmi/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApplication());
}

class BmiApplication extends StatefulWidget {
  const BmiApplication({super.key});

  @override
  State<BmiApplication> createState() => _BmiApplicationState();
}

class _BmiApplicationState extends State<BmiApplication> {
  @override
  Widget build(BuildContext context) {
    return getMaterial();
  }
}


Widget getMaterial(){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'dana'),
    home: HomeScreen(),
  );
}
