import 'package:fastuserapp/src/models/varient.dart';
import 'package:fastuserapp/src/widgets/varient_button_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VarientButtonBar extends StatefulWidget {
  final List<Varient> varients;
  final ValueChanged<Varient> onChange;
  final Varient selectedVarient;

  const VarientButtonBar({
    Key key,
    this.varients,
    this.onChange,
    this.selectedVarient,
  }) : super(key: key);

  @override
  _VarientButtonBarState createState() => _VarientButtonBarState();
}

class _VarientButtonBarState extends State<VarientButtonBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Varients",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.orange[300],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.varients
                  .map(
                    (varient) => VarientButtonItem(
                      varient: varient,
                      isSelected: widget.selectedVarient == varient,
                      onPressed: () {
                        widget.onChange(varient);
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
