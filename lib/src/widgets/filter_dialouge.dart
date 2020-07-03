import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/search_bloc.dart';
import 'package:fastuserapp/src/widgets/filter_option.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDialouge extends StatefulWidget {
  @override
  _FilterDialougeState createState() => _FilterDialougeState();
}

class _FilterDialougeState extends State<FilterDialouge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
            height: constraint.maxHeight * 0.30,
            padding: EdgeInsets.all(
              10,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "What are you looking for ?",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: StreamBuilder<String>(
                      stream: searchBloc.searchFilter,
                      builder: (context, snapshot) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: FilterOption(
                                margin: EdgeInsets.only(
                                  top: 10,
                                  right: 5,
                                ),
                                isActive:
                                    snapshot.data == "resturant" ? true : false,
                                onTap: () =>
                                    searchBloc.changeSearchFilter("resturant"),
                                icon: Icons.restaurant,
                                name: "Resturant",
                              ),
                            ),
                            Expanded(
                              child: FilterOption(
                                margin: EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                ),
                                isActive:
                                    snapshot.data == "food" ? true : false,
                                onTap: () =>
                                    searchBloc.changeSearchFilter("food"),
                                icon: Icons.restaurant_menu,
                                name: "Food",
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
