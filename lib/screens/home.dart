import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShadButton(
              child: Row(
                children: [
                  Icon(Icons.mosque),
                  Text("Mosque")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
