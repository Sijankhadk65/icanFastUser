import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/bloc/dash_bloc.dart';
import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/screens/quick_access_screen.dart';
import 'package:fastuserapp/src/screens/vendor_list_screen.dart';
import 'package:fastuserapp/src/widgets/categories_card.dart';
import 'package:fastuserapp/src/widgets/quick_access_card.dart';
import 'package:flutter/material.dart';
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
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 22 / 9,
              children: <Widget>[
                CategoriesCard(
                  assetPath: "assets/svg/cafe.svg",
                  category: "Restaurants",
                  message: "A list of curated resturants near you.",
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
                  assetPath: "assets/svg/bakery-shop.svg",
                  category: "Bakeries",
                  message: "A selection of the best bakeries for you.",
                  onTap: () {},
                ),
                CategoriesCard(
                  assetPath: "assets/svg/liquor.svg",
                  category: "Liquors",
                  message: "Satisfy your thirst the FAST way.",
                  onTap: () {},
                ),
                CategoriesCard(
                  assetPath: "assets/svg/discount.svg",
                  category: "Offers",
                  message: "Enjoy our in-app offers on food.",
                  onTap: () {},
                ),
              ],
            ),
          ),
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
                              15,
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
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
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                  title: "Most Searched",
                  description:
                      "A list of most searched Resturants and food items.",
                  assetPath: "assets/svg/food-delivery.svg",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuickAccessScreen(),
                      ),
                    );
                  },
                ),
                QuickAccessCard(
                  title: "Favourites",
                  description:
                      "Your favourite resturants and food all in one place",
                  assetPath: "assets/svg/wishlist.svg",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuickAccessScreen(),
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
                        builder: (_) => QuickAccessScreen(),
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
                        builder: (_) => QuickAccessScreen(),
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
                        builder: (_) => QuickAccessScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(
                    0,
                    5,
                  ),
                )
              ],
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
