import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
  final String assetPath;
  final String title, subtitle;
  final Widget child;

  const OnboardingPage({
    Key key,
    this.child,
    this.title,
    this.subtitle,
    this.assetPath,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SvgPicture.asset(
            assetPath,
            height: 200,
            width: 200,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            title,
            style: GoogleFonts.oswald(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.nunito(
            letterSpacing: 1.5,
          ),
        ),
        child,
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
