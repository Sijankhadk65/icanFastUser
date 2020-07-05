import 'package:flutter/material.dart';

class AddOnItem extends StatefulWidget {
  final String addOn;
  final Function(bool) onChecked;

  const AddOnItem({
    Key key,
    this.addOn,
    this.onChecked,
  }) : super(key: key);

  @override
  _AddOnItemState createState() => _AddOnItemState();
}

class _AddOnItemState extends State<AddOnItem> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          checkColor: Colors.blue,
          activeColor: Colors.white,
          value: _checked,
          onChanged: (value) {
            this.setState(() {
              _checked = !_checked;
            });
            widget.onChecked(value);
          },
        ),
        Text(widget.addOn)
      ],
    );
  }
}
