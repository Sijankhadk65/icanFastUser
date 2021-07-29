import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/cart_item_bloc.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/widgets/add_to_cart_dialouge.dart';
import 'package:fastuserapp/src/widgets/app_alert.dart';
import 'package:fastuserapp/src/widgets/custom_tab_bar.dart';
import 'package:fastuserapp/src/widgets/menu_item_displayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../bloc/ratings_bloc.dart';
import '../models/online_order.dart';
import '../screens/cart_screen.dart';
import '../screens/rating_screen.dart';
import '../bloc/order_cart_bloc.dart';
import 'package:provider/provider.dart';

class VendorScreen extends StatefulWidget {
  final String vendorName, vendorID;
  final List<String> categories;
  final Map<String, dynamic> user;
  final int minOrder;
  final double vendorRating;
  final bool shouldSchedule, isNight;
  final DateTime openingTime, closingTime;

  const VendorScreen(
      {Key key,
      @required this.vendorName,
      @required this.categories,
      this.user,
      this.minOrder,
      this.vendorRating,
      this.vendorID,
      this.shouldSchedule = false,
      this.openingTime,
      this.closingTime,
      this.isNight})
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
    orderCartBloc.getCurrentOrder(widget.vendorID);
    orderCartBloc.getCartLenth(widget.vendorID);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.vendorName,
              ),
            ),
          ],
        ),
        actions: [
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
          ),
        ],
      ),
      body: Column(
        children: [
          widget.shouldSchedule
              ? AppAlert(
                  priority: "warning",
                  message:
                      "The vendor is closed at the moment but you can place an order for later.",
                )
              : Container(),
          Expanded(
            child: CustomTabView(
              itemCount: widget.categories.length,
              tabBuilder: (context, index) => Text(widget.categories[index]),
              pageBuilder: (context, index) => StreamBuilder<List<MenuItem>>(
                stream: _cartMenuBloc.getMenu(
                  widget.categories[index],
                  widget.vendorID,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("Awaiting Bids....");
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          fontSize: 100,
                        ),
                      );
                      break;
                    case ConnectionState.active:
                      return snapshot.data.isNotEmpty
                          ? StreamBuilder<List<String>>(
                              stream: _cartMenuBloc.getFavourites(
                                  "food", widget.user['email']),
                              builder: (context, favouriteSnapshot) {
                                if (favouriteSnapshot.hasError)
                                  return Text("${favouriteSnapshot.error}");
                                switch (favouriteSnapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("Awaiting Bids...");
                                    break;
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: JumpingDotsProgressIndicator(
                                        fontSize: 20.0,
                                      ),
                                    );
                                    break;
                                  case ConnectionState.active:
                                    return GridView.count(
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
                                      children: snapshot.data
                                          .map<Widget>(
                                            (f) => MenuItemDisplayer(
                                              item: f,
                                              isFeatured: favouriteSnapshot.data
                                                  .contains(f.name),
                                              onTap: () {
                                                _cartMenuBloc.toogleFavourite(
                                                  favouriteSnapshot.data
                                                      .contains(f.name),
                                                  "food",
                                                  widget.user['email'],
                                                  {
                                                    "name": f.name,
                                                    "createdAt": f.createdAt,
                                                  },
                                                );
                                              },
                                              onTapped: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      Provider(
                                                    create: (_) =>
                                                        CartItemBloc(),
                                                    dispose: (context,
                                                            CartItemBloc
                                                                bloc) =>
                                                        bloc.dispose(),
                                                    child: AddToCartDialouge(
                                                      openingTime:
                                                          widget.openingTime,
                                                      closingTime:
                                                          widget.closingTime,
                                                      item: f,
                                                      user: widget.user,
                                                      vendorName:
                                                          widget.vendorName,
                                                      vendorID: widget.vendorID,
                                                      minOrder: widget.minOrder,
                                                      shouldSchedule:
                                                          widget.shouldSchedule,
                                                    ),
                                                  ),
                                                );
                                              },
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
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/empty.svg",
                                    height: 200,
                                    width: 200,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Text(
                                      "",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ),
                                ],
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
                                          orderSnapshot.data.vendorName,
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
