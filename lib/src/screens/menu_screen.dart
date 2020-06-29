import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_menu_bloc.dart';
import '../models/vendor.dart';
import '../screens/vendors_screen.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/source_card.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const MenuScreen({Key key, this.user}) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  CartMenuBloc _cartMenuBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getTags();
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange[100],
              style: BorderStyle.solid,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: StreamBuilder<String>(
              stream: _cartMenuBloc.query,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: _cartMenuBloc.changeQuery,
                  style: GoogleFonts.montserrat(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.montserrat(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                      hintText: "Search for foods sources......"),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: StreamBuilder<String>(
                stream: _cartMenuBloc.query,
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data.isNotEmpty
                      ? StreamBuilder<List<Vendor>>(
                          stream: _cartMenuBloc.queryItems,
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text("Error: ${snapshot.error}");
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text("Awaiting bids");
                                break;
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                                break;
                              case ConnectionState.active:
                                return ListView(
                                  shrinkWrap: true,
                                  children: snapshot.data
                                      .map(
                                        (vendor) => SourceCard(
                                          vendor: vendor,
                                          user: widget.user,
                                          minOrder: vendor.minOrder,
                                        ),
                                      )
                                      .toList(),
                                );
                                break;
                              case ConnectionState.done:
                                return Text("The task has completed");
                                break;
                            }
                            return null;
                          })
                      : StreamBuilder<List<String>>(
                          stream: _cartMenuBloc.tags,
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text("Error: ${snapshot.error}");
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text("Awaiting Bids....");
                                break;
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                                break;
                              case ConnectionState.active:
                                return CustomTabView(
                                  itemCount: snapshot.data.length,
                                  tabBuilder: (context, index) =>
                                      Text(snapshot.data[index].toUpperCase()),
                                  pageBuilder: (context, index) => Provider(
                                    create: (_) => CartMenuBloc(),
                                    child: VendorsScreen(
                                        tag: snapshot.data[index],
                                        user: widget.user),
                                  ),
                                );
                                break;
                              case ConnectionState.done:
                                return Text("The task has completed");
                                break;
                            }
                            return null;
                          },
                        );
                }),
          ),
        ),
      ],
    );
  }
}
