import 'package:fastuserapp/src/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class QuickAccessScreen extends StatefulWidget {
  @override
  _QuickAccessScreenState createState() => _QuickAccessScreenState();
}

class _QuickAccessScreenState extends State<QuickAccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: CustomTabView(
            itemCount: 2,
            tabBuilder: (context, index) => Text("Page"),
            pageBuilder: (context, index) => Container()),
      ),
    );
  }
}
