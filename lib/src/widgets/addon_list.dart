import 'package:fastuserapp/src/models/add_on.dart';
import 'package:fastuserapp/src/widgets/addon_item.dart';
import 'package:flutter/material.dart';

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
      height: 100,
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
    );
  }
}
