import 'package:dotted_line/dotted_line.dart';
import 'package:fastuserapp/src/models/add_on.dart';
import 'package:fastuserapp/src/widgets/addon_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOnList extends StatefulWidget {
  final List<AddOn> addOns, selectedAddOns;
  final ValueChanged<AddOn> onTap;
  const AddOnList({
    Key key,
    this.addOns,
    this.selectedAddOns,
    this.onTap,
  }) : super(key: key);
  @override
  _AddOnListState createState() => _AddOnListState();
}

class _AddOnListState extends State<AddOnList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5,
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            children: [
              Text(
                "Add Ons",
                style: GoogleFonts.oswald(
                  fontSize: 27,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: DottedLine(
                  dashColor: Colors.orange,
                  dashRadius: 5,
                  lineThickness: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: widget.addOns
                      .map(
                        (addon) => AddOnItem(
                          addOn: addon,
                          isAdded: widget.selectedAddOns.contains(addon),
                          onTap: () {
                            widget.onTap(addon);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
