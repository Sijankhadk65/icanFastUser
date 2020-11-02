import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartAlerts extends StatelessWidget {
  final String message;
  final Color indicator;
  const CartAlerts({
    Key key,
    this.message,
    this.indicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            right: 5,
            bottom: 5,
          ),
          child: Transform.rotate(
            angle: pi / 12.5,
            child: Icon(
              EvaIcons.alertCircle,
              color: indicator,
              size: 20,
            ),
          ),
        ),
        Expanded(
          child: Text(
            message,
            style: GoogleFonts.montserrat(
              color: indicator,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
