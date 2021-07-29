import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/bakeries_bloc.dart';
import 'package:fastuserapp/src/bloc/cart_item_bloc.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/bloc/dash_bloc.dart';
import 'package:fastuserapp/src/bloc/liquor_bloc.dart';
import 'package:fastuserapp/src/bloc/offers_bloc.dart';
import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/models/community_item.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/screens/bakeries_screen.dart';
import 'package:fastuserapp/src/screens/coming_soon_screen.dart';
import 'package:fastuserapp/src/screens/favourites_screen.dart';
import 'package:fastuserapp/src/screens/liquor_screen.dart';
import 'package:fastuserapp/src/screens/offers_screen.dart';
import 'package:fastuserapp/src/screens/quick_access_screen.dart';
import 'package:fastuserapp/src/screens/vendor_list_screen.dart';
import 'package:fastuserapp/src/widgets/add_to_cart_dialouge.dart';
import 'package:fastuserapp/src/widgets/categories_card.dart';
import 'package:fastuserapp/src/widgets/community_card.dart';
import 'package:fastuserapp/src/widgets/featured_item_card.dart';
import 'package:fastuserapp/src/widgets/quick_access_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const DashScreen({Key key, this.user}) : super(key: key);
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  DashBloc _dashBloc;
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _dashBloc = Provider.of<DashBloc>(context);
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getTags();
    _dashBloc.getFeaturedVendor();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: StreamBuilder<List<CarouselItem>>(
                stream: _dashBloc.getCarouselItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text("Error:${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("Awaiting Bids....");
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: Center(child: CircularProgressIndicator()),
                      );
                      break;
                    case ConnectionState.active:
                      return CarouselSlider.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => CachedNetworkImage(
                          imageUrl: snapshot.data[index].photoURI,
                          progressIndicatorBuilder: (context, msg, progress) =>
                              Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                onTap: snapshot.data[index].isInteractive
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Provider(
                                            create: (_) => CartItemBloc(),
                                            child: StreamBuilder<MenuItem>(
                                              stream: _cartMenuBloc.getMenuItem(
                                                  snapshot
                                                      .data[index].itemCode),
                                              builder: (context, itemSnapshot) {
                                                if (itemSnapshot.hasError)
                                                  return Text(
                                                      "Error:${itemSnapshot.error}");
                                                switch (itemSnapshot
                                                    .connectionState) {
                                                  case ConnectionState.none:
                                                    return Text(
                                                        "awaiting bids....");
                                                    break;
                                                  case ConnectionState.waiting:
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                    break;
                                                  case ConnectionState.active:
                                                    return AddToCartDialouge(
                                                      item: itemSnapshot.data,
                                                      minOrder: snapshot
                                                          .data[index].minOrder,
                                                      vendorName: snapshot
                                                          .data[index]
                                                          .vendorName,
                                                      user: widget.user,
                                                    );
                                                    break;
                                                  case ConnectionState.done:
                                                    return Text(
                                                      "The task has completed",
                                                    );
                                                    break;
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    : () {},
                              ),
                            ),
                          ),
                          errorWidget: (context, msg, error) => Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          aspectRatio: 16 / 7,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      );

                      break;
                    case ConnectionState.done:
                      return Text("The task has completed");
                      break;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
                bottom: 10,
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 16 / 9,
                children: <Widget>[
                  CategoriesCard(
                    assetPath: "assets/background/restaurant.jpg",
                    category: "Restaurants",
                    message: "A curated list of resturants near you.",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Provider(
                            create: (_) => CartMenuBloc(),
                            child: VendorListScreen(
                              user: widget.user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CategoriesCard(
                    assetPath: "assets/background/cakesandbakeries.jpg",
                    category: "Cakes and Bakeries",
                    message: "A selection of the best bakeries for you.",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiProvider(
                            providers: [
                              Provider(
                                create: (_) => BakeriesBloc(),
                              ),
                              Provider(
                                create: (_) => CartMenuBloc(),
                              ),
                            ],
                            child: BakeriesScreen(
                              user: widget.user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CategoriesCard(
                    assetPath: "assets/background/liquors.jpg",
                    category: "Liquors",
                    message: "Satisfy your thirst the FAST way.",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiProvider(
                            providers: [
                              Provider(
                                create: (_) => LiquorBloc(),
                              ),
                              Provider(
                                create: (_) => CartMenuBloc(),
                              ),
                            ],
                            child: LiquorScreen(
                              user: widget.user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CategoriesCard(
                    assetPath: "assets/background/groceries.jpg",
                    category: "Groceries",
                    message: "Your one stop for all your groceries.",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ComingSoon(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "The Community",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.orange[600],
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            StreamBuilder<List<CommunityItem>>(
                stream: _dashBloc.getCommunityItems(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("Awaiting Bids....");
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: Center(child: CircularProgressIndicator()),
                      );
                      break;
                    default:
                      break;
                  }
                  return Container(
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 150,
                            margin: EdgeInsets.only(),
                            child: CommunityCard(
                              title: snapshot.data[index].title,
                              communityItem: snapshot.data[index],
                              description: "The provide awesome thing",
                              assetPath: "assets/background/community.jpg",
                              user: widget.user,
                            ));
                      },
                    ),
                  );
                }),
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  QuickAccessCard(
                    title: "Favourites",
                    description:
                        "Your favourite resturants and food all in one place",
                    assetPath: "assets/svg/wishlist.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Provider(
                            create: (_) => CartMenuBloc(),
                            child: FavouriteScren(
                              user: widget.user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  QuickAccessCard(
                    title: "Veg Food",
                    description: "Vegeterians don't worry we got you covered.",
                    assetPath: "assets/svg/diet.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Provider(
                            create: (_) => CartMenuBloc(),
                            child: QuickAccessScreen(
                              type: "veg",
                              user: widget.user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  QuickAccessCard(
                    title: "Halal Food",
                    description:
                        "A curated list of resturant and food that are halal certified.",
                    assetPath: "assets/svg/halal.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Provider(
                            create: (_) => CartMenuBloc(),
                            child: QuickAccessScreen(
                              type: "halal",
                              user: widget.user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  QuickAccessCard(
                    title: "Offers",
                    description: "Checkout these offers that we have for you.",
                    assetPath: "assets/svg/discount.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Provider(
                            create: (_) => OffersBloc(),
                            child: OffersScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //     top: 10,
            //   ),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         Colors.orange[300],
            //         Colors.orange[900],
            //       ],
            //     ),
            //   ),
            //   child: StreamBuilder<Vendor>(
            //     stream: _dashBloc.featuredVendor,
            //     builder: (context, featuredVendorSnapshot) {
            //       if (featuredVendorSnapshot.hasError)
            //         return Text("Error: ${featuredVendorSnapshot.error}");
            //       switch (featuredVendorSnapshot.connectionState) {
            //         case ConnectionState.none:
            //           return Text("Awaiting Bids...");
            //           break;
            //         case ConnectionState.waiting:
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //           break;
            //         case ConnectionState.active:
            //           return Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Container(
            //                 decoration: BoxDecoration(
            //                   gradient: LinearGradient(
            //                     begin: Alignment.topLeft,
            //                     end: Alignment.bottomRight,
            //                     colors: [
            //                       Colors.white.withAlpha(
            //                         100,
            //                       ),
            //                       Colors.white.withAlpha(
            //                         50,
            //                       ),
            //                       Colors.white.withAlpha(
            //                         20,
            //                       ),
            //                     ],
            //                   ),
            //                   borderRadius: BorderRadius.only(
            //                     bottomLeft: Radius.circular(
            //                       55,
            //                     ),
            //                   ),
            //                 ),
            //                 padding: EdgeInsets.all(
            //                   20,
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           margin: EdgeInsets.only(
            //                             left: 25,
            //                           ),
            //                           child: Text(
            //                             "Pick of the week!",
            //                             style: GoogleFonts.oswald(
            //                               fontSize: 15,
            //                               color: Colors.orange,
            //                               fontStyle: FontStyle.italic,
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           margin: EdgeInsets.only(
            //                             left: 15,
            //                           ),
            //                           child: Text(
            //                             featuredVendorSnapshot.data.name
            //                                 .toUpperCase(),
            //                             style: GoogleFonts.oswald(
            //                               fontSize: 25,
            //                               fontWeight: FontWeight.w700,
            //                               color: Colors.white,
            //                               fontStyle: FontStyle.italic,
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           margin: EdgeInsets.only(
            //                             left: 15,
            //                           ),
            //                           child: Material(
            //                             // elevation: 10,
            //                             color: Colors.orange[300],
            //                             borderRadius: BorderRadius.circular(
            //                               5,
            //                             ),
            //                             child: Padding(
            //                               padding: EdgeInsets.symmetric(
            //                                 horizontal: 10,
            //                                 vertical: 5,
            //                               ),
            //                               child: Text(
            //                                 "Rating: ${featuredVendorSnapshot.data.averageRating}",
            //                                 style: GoogleFonts.nunito(
            //                                   color: Colors.white,
            //                                   fontWeight: FontWeight.w800,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               StreamBuilder<List<MenuItem>>(
            //                 stream: _dashBloc.getFeaturedMenuItems(
            //                   featuredVendorSnapshot.data.id,
            //                 ),
            //                 builder: (context, snapshot) {
            //                   if (snapshot.hasError)
            //                     return Text("Error: ${snapshot.error}");
            //                   switch (snapshot.connectionState) {
            //                     case ConnectionState.none:
            //                       return Text("Awaiting Bids...");
            //                       break;
            //                     case ConnectionState.waiting:
            //                       return Center(
            //                         child: CircularProgressIndicator(),
            //                       );
            //                       break;
            //                     case ConnectionState.active:
            //                       return SizedBox(
            //                         height: 230,
            //                         child: ListView(
            //                           padding: EdgeInsets.only(
            //                             left: 10,
            //                             top: 10,
            //                             bottom: 15,
            //                           ),
            //                           scrollDirection: Axis.horizontal,
            //                           shrinkWrap: true,
            //                           children: snapshot.data
            //                               .map(
            //                                 (item) => FeaturedItemCard(
            //                                   item: item,
            //                                   minOrder: featuredVendorSnapshot
            //                                       .data.minOrder,
            //                                   vendorName: featuredVendorSnapshot
            //                                       .data.name,
            //                                   user: widget.user,
            //                                   addToCart: () => showDialog(
            //                                     context: context,
            //                                     builder: (context) => Provider(
            //                                       create: (_) => CartItemBloc(),
            //                                       dispose: (context,
            //                                               CartItemBloc bloc) =>
            //                                           bloc.dispose(),
            //                                       child: AddToCartDialouge(
            //                                         item: item,
            //                                         minOrder:
            //                                             featuredVendorSnapshot
            //                                                 .data.minOrder,
            //                                         vendorName:
            //                                             featuredVendorSnapshot
            //                                                 .data.name,
            //                                         user: widget.user,
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               )
            //                               .toList(),
            //                         ),
            //                       );
            //                       break;
            //                     case ConnectionState.done:
            //                       return Container();
            //                       break;
            //                   }
            //                   return Container();
            //                 },
            //               ),
            //             ],
            //           );
            //           break;
            //         case ConnectionState.done:
            //           return Text("The task has completed");
            //           break;
            //       }
            //       return Container();
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
