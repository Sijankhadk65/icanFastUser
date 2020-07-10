import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePhoneNumberDialog extends StatefulWidget {
  final TextEditingController phoneNumberController;
  final Function(String) onPhoneNumberChanged;
  final Function() onChangePressed;

  const ChangePhoneNumberDialog({
    Key key,
    this.phoneNumberController,
    this.onPhoneNumberChanged,
    this.onChangePressed,
  }) : super(key: key);
  @override
  _ChangePhoneNumberDialogState createState() =>
      _ChangePhoneNumberDialogState();
}

class _ChangePhoneNumberDialogState extends State<ChangePhoneNumberDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Enter a different number",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextField(
                    controller: widget.phoneNumberController,
                    onChanged: widget.onPhoneNumberChanged,
                  ),
                  Row(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                        onPressed: widget.onChangePressed,
                        child: Text(
                          "Change",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
