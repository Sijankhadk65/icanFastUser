import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import '../bloc/cart_menu_bloc.dart';
import '../bloc/order_cart_bloc.dart';
import '../models/item.dart';
import 'package:provider/provider.dart';
import '../widgets/menu_item_displayer.dart';

class MenuBuilder extends StatefulWidget {
  final String category, vendorName;
  final Map<String, dynamic> user;
  const MenuBuilder({Key key, this.category, this.vendorName, this.user})
      : super(key: key);
  @override
  _MenuBuilderState createState() => _MenuBuilderState();
}

class _MenuBuilderState extends State<MenuBuilder> {
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getMenu(widget.category, widget.vendorName);
    return Container(
      child: StreamBuilder<List<MenuItem>>(
        stream: _cartMenuBloc.cartMenu,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Select lot');
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return snapshot.data.isNotEmpty
                  ? GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: snapshot.data
                          .map<Widget>(
                            (f) => MenuItemDisplayer(
                                item: f,
                                onTapped: () {
                                  orderCartBloc.addNewOrder(
                                    widget.vendorName,
                                    f,
                                    widget.user,
                                  );
                                  Toast.show("${f.name} added to cart", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.CENTER);
                                }),
                          )
                          .toList(),
                    )
                  : Center(
                      child: Text(
                        "no items here!",
                        style: GoogleFonts.pacifico(
                          fontSize: 30,
                        ),
                      ),
                    );

            case ConnectionState.done:
              return Text('${snapshot.data} (closed)');
          }
          return null;
        },
      ),
    );
  }
}
