import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/widgets/custom_tab_bar.dart';
import 'package:fastuserapp/src/widgets/menu_item_displayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import '../bloc/ratings_bloc.dart';
import '../models/online_order.dart';
import '../screens/cart_screen.dart';
import '../screens/rating_screen.dart';
import '../bloc/order_cart_bloc.dart';
import 'package:provider/provider.dart';

class VendorScreen extends StatefulWidget {
  final String vendorName;
  final List<String> categories;
  final Map<String, dynamic> user;
  final int minOrder;
  final double vendorRating;

  const VendorScreen(
      {Key key,
      @required this.vendorName,
      @required this.categories,
      this.user,
      this.minOrder,
      this.vendorRating})
      : super(key: key);
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen>
    with SingleTickerProviderStateMixin {
  double height = 65;
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getLocalOrder();
    orderCartBloc.getCurrentOrder(widget.vendorName);
    orderCartBloc.getCartLenth(widget.vendorName);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.vendorName,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Provider(
                      create: (_) => RatingsBloc(),
                      child: RatingScreen(
                        user: widget.user,
                        vendorName: widget.vendorName,
                      ),
                    ),
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    EvaIcons.star,
                    color: Colors.yellow[800],
                  ),
                  Text(
                    "(${widget.vendorRating})",
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 10,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomTabView(
              itemCount: widget.categories.length,
              tabBuilder: (context, index) => Text(widget.categories[index]),
              pageBuilder: (context, index) => StreamBuilder(
                stream: _cartMenuBloc.getMenu(
                    widget.categories[index], widget.vendorName),
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
                                          Toast.show("${f.name} added to cart",
                                              context,
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
                      break;
                    case ConnectionState.done:
                      return Text("The task has completed.");
                      break;
                  }
                  return null;
                },
              ),
            ),
          ),
          StreamBuilder<List<OnlineOrder>>(
            stream: orderCartBloc.localOrder,
            builder: (context, localOrder) {
              return StreamBuilder<OnlineOrder>(
                stream: orderCartBloc.currentOrder,
                builder: (context, orderSnapshot) {
                  return LayoutBuilder(
                    builder: (context, constraint) {
                      return orderSnapshot.hasData
                          ? Container(
                              height: 65,
                              child: Material(
                                color: Colors.blue[800],
                                elevation: 10,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CartScreen(
                                          user: widget.user,
                                          vendor: widget.vendorName,
                                          minOrder: widget.minOrder,
                                          orderCartLength:
                                              localOrder.data.length,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          orderSnapshot.data.vendor,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              StreamBuilder<int>(
                                                  stream:
                                                      orderCartBloc.totalLength,
                                                  builder: (context, snapshot) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10.0,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: Container(
                                                              height: 15,
                                                              width: 15,
                                                              child: Material(
                                                                color: Colors
                                                                        .orange[
                                                                    800],
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    15,
                                                                  ),
                                                                ),
                                                                elevation: 5,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${snapshot.data}",
                                                                    style: GoogleFonts
                                                                        .oswald(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                              Center(
                                                child: StreamBuilder(
                                                  stream:
                                                      orderCartBloc.totalPrice,
                                                  builder: (context, snapshot) {
                                                    return Center(
                                                      child: Text(
                                                        "Total Cost (Rs.${snapshot.data})",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
