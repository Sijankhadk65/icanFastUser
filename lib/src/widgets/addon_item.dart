import 'package:fastuserapp/src/models/add_on.dart';
import 'package:flutter/material.dart';

class AddOnItem extends StatefulWidget {
  final AddOn addOn;
  final bool isAdded;
  final Function() onTap;

  const AddOnItem({
    Key key,
    this.addOn,
    this.isAdded,
    this.onTap,
  }) : super(key: key);
  @override
  _AddOnItemState createState() => _AddOnItemState();
}

class _AddOnItemState extends State<AddOnItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isAdded ? Colors.orange : Colors.grey,
      margin: EdgeInsets.all(
        5,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.addOn.name,
                ),
              ),
              Text(
                "${widget.addOn.price}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
