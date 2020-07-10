import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangableDisplayer extends StatelessWidget {
  final String primaryText, secondaryText;
  final Function() displayChanger;

  const ChangableDisplayer({
    Key key,
    this.primaryText,
    this.secondaryText,
    this.displayChanger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 5,
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
          text: primaryText,
          children: [
            TextSpan(
              text: secondaryText,
              recognizer: TapGestureRecognizer()..onTap = displayChanger,
              style: GoogleFonts.nunito(
                color: Colors.blue,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
