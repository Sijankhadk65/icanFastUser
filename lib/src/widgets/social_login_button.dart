import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLoginButton extends StatelessWidget {
  final Color fillColour, spalshColour;
  final String asset, name;
  final VoidCallback onPressed;
  const SocialLoginButton({
    Key key,
    this.fillColour = Colors.white,
    this.spalshColour = Colors.black26,
    this.asset,
    this.name,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: fillColour,
      splashColor: spalshColour,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              asset,
              height: 25,
              width: 25,
            ),
            SizedBox.fromSize(
              size: Size(10, 10),
            ),
            Text(
              "Signup with $name",
              style: GoogleFonts.openSans(
                  color:
                      fillColour == Colors.white ? Colors.black : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
