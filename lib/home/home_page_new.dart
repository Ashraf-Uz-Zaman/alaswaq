import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/cart_list_model.dart';
import 'package:Alaswaq/Model/popular_model.dart';
import 'package:Alaswaq/Model/price_model.dart';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input2.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/product/search/price_search.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/search/search_home_cat_buttons.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/product/single_product/popular_single_product.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';


class HomePage extends StatefulWidget {
  static CartListModel cartListModel;

  static var cartCount = 0;

  static List<Address> addressValue;
  static var isGuestManagement = false;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<String> productCategories = [
    'assets/images/icons/fruits.png',
    'assets/images/icons/vegetables.png',
    'assets/images/icons/seafood.png',
    'assets/images/icons/meat.png',
    'assets/images/icons/bakery.png',
    'assets/images/icons/dairy.png',
    'assets/images/icons/drinks.png',
    'assets/images/icons/chicken.png',
  ];

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  TextEditingController controller;

  int categoryIndex = 0;


  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

//  static var isLogin = false;
  static var isLogin = false;
   ProductListModel productList;
  ProductListModel popularList;
   var popularListImage = [];
  var bestSellingListImage = [];
   var productqty = [];
   var productPrice = [];
//  static var allOptionPrice = [];
   var productSku = [];
//  static var allProductSku = [];
   var productType = [];
   var popularqty = [];
   var popularPrice = [];
   var popularSku = [];
   var popularType = [];
  var bestSellingqty = [];

  var hotProductQty = [];
   ProductListModel bestSellingList;
  ProductListModel topSellingList;
  static var userName = "";
  var subTotal = 0.0;
  var grandTotal = 0.0;
  var vat = 0;
  var bannerCount = 1 ;
  var isnetworkAvailable = false;
    List<String>bannetList = [];
   List<String>categoryBannerList = [];
  List<String>offerBannerList = [];
  List<String>add1BannerList = [];
  List<String>add2BannerList = [];
  var bannerUrl1 = "http://www.aswaqrak.ae/pub/media/";
  var bannerUrl2 = "http://www.aswaqrak.ae/pub/media/";
  var pressed1 = true;

  var pressed2 = false;

  var pressed3 = false;

  var pressed4 = false;

  var pressed5 = false;

  var pressed6 = false;

  var pressed7 = false;

  var pressed8 = false;
   List<Widget> imageSliders = [];
  bool _progressController = true;
  var qty = 1;
  var searchName;
  int _current = 0;

  @override
  void initState() {
    super.initState();
        searchController.text = searchName;
        bannetList = [];
//    numberController.text = "1";
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
           setState(() {
             _progressController = false;
             isnetworkAvailable = false;
           });
            print("no internet");

          } else {
            setState(() {

              isnetworkAvailable = true;
            });
            isLoggedIn();
            loadBanner();
            loadCoupenBanner();
            loadCategoryBanner();
//    freshFoodBanner();
            getProductList();
//
            getBestSellingList();
           getHotSellingList();
            listenForAdminKey();
            getHealthcareProduct();
          }




      }
  );



  }

  @override
  dispose() {
    super.dispose();
//    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: AppColor.whiteColor,
      backgroundColor: Colors.white,
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
//          toolbarHeight: 30,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => _key.currentState.openDrawer(),
//            child: Icon(
//              Icons.dehaze,
//              color: Colors.black87,
//              size: 40,
//            ),

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Image.asset(
                'assets/images/icons/drawer.png',
              ),
            ),
//            child: Container(
//              height: 10,
//              width: 100,
//              child: Image.asset(
//                'assets/images/icons/drawer.png',
//              ),
//            ),
          ),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
//          width: 100,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShoppingCart()));
            },
//                    child: Image.asset(
//                      'assets/images/icons/cart.png',
//                      height: 35,
////          height:10,
////          width: 100,
//                    ),
            child: new Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Image.asset(
                    'assets/images/icons/cart.png',
                    height: 35,
                  ),
                ),
                HomePage.cartCount == 0 ||   HomePage.cartCount == null
                    ? new Container()
                    : new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 22.0, color: Colors.redAccent),
                          new Positioned(
                            top: 3.0,
                            right: 7.0,
                            child: new Center(
                              child: new Text(
                                HomePage.cartCount.toString(),
                                style: new TextStyle( fontFamily: 'montserrat',
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),


      body:  isnetworkAvailable ?  _progressController
          ?  Center(
        child: SpinKitPulse(
          color: Colors.red,
          size: 50.0,
        ),
      )

          :
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//        Padding(
//        padding: const EdgeInsets.only(
//            top: 10, left: 0, right: 0, bottom: 0),
//        child:
//            CarouselSlider(
//              options: CarouselOptions(
//                height: 230,
//                viewportFraction: 1.0,
//                enlargeCenterPage: false,
//                // autoPlay: false,
//              ),
//              items: bannetList.map((item) => Container(
//                child: Center(
//                  child:
//                  CachedNetworkImage(
//                    fit: BoxFit.fill,
//                    height: 230,
//
//                    imageUrl: item,
//                    placeholder: (context, url) => Center(
//                      child: SpinKitPulse(
//                        color: Colors.red,
//                        size: 50.0,
//                      ),
//                    ),
//                    errorWidget: (context, url, error) => Image(
//                      fit: BoxFit.fill,
//                      height: 400,
//                      image: AssetImage('assets/images/bg2.jpg', ),
//                    ),
//                  ),
////                        Image.network(item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width)
//                ),
//              )).toList(),
//            ),
//        ),
         Column(
             children: [
               CarouselSlider(
                 items: imageSliders,
                 options: CarouselOptions(
                     height: 170,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                     autoPlay: true,
                     onPageChanged: (index, reason) {
                       setState(() {
                         _current = index;
                       });
                     }
                 ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: bannetList.map((url) {
                   int index = bannetList.indexOf(url);
                   return Container(
                     width: 8.0,
                     height: 8.0,
                     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: _current == index
                           ? Color.fromRGBO(0, 0, 0, 0.9)
                           : Color.fromRGBO(0, 0, 0, 0.4),
                     ),
                   );
                 }).toList(),
               ),
             ]
         ),
//              Text("Dummy Text"),
            Stack(

              children: [


                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFDAD4D1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: searchController,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value)  {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchFromHome(
                                                  name: searchController.text
                                              )));


                                },
                                decoration: InputDecoration(

                                    contentPadding: EdgeInsets.only(
                                      bottom: 0,
                                      left: 20,
                                      top: 15,
                                      // HERE THE IMPORTANT PART
                                    ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Find your products here...",
                                  prefixIcon: Icon(
                                    Icons.search,
                                  ),
                                ),
                                style: TextStyle( fontFamily: 'montserrat',
                                    fontSize: 14 // This is not so important
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF99A922),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchFromHome(
                                                name: searchController.text
                                              )));


                                },
                                child: Text(
                                  'Search',
                                  style: TextStyle( fontFamily: 'montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            verticalSpace(),
            Container(
              margin: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 = !pressed1;
                                    pressed2 = false;
                                    pressed3 = false;
                                    pressed4 = false;
                                    pressed5 = false;
                                    pressed6 = false;
                                    pressed7 = false;
                                    pressed8 = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShowHomeButtonCatPage("from home",100,

                                                )),
                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/fruits.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Fruits",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 = false;
                                    pressed2 = false;
                                    pressed3 = !pressed3;
                                    pressed4 = false;
                                    pressed5 = false;
                                    pressed6 = false;
                                    pressed7 = false;
                                    pressed8 = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShowHomeButtonCatPage( "from home", 101)),
                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/vegetables.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Vegetables",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 = false;
                                    pressed2 = false;
                                    pressed3 = false;
                                    pressed4 = !pressed4;
                                    pressed5 = false;
                                    pressed6 = false;
                                    pressed7 = false;
                                    pressed8 = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowHomeButtonCatPage( "from home", 111)),

                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/seafood.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Seafood",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 =  false;
                                    pressed2 = false ;
                                    pressed3 = false;
                                    pressed4 = !pressed4;
                                    pressed5 = false;
                                    pressed6 = false;
                                    pressed7 = false;
                                    pressed8 = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowHomeButtonCatPage( "from home", 107)),

                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/meat.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Meat",
                            style: TextStyle( fontFamily: 'montserrat', 
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 =  false;
                                    pressed2 = false ;
                                    pressed3 = false;
                                    pressed4 = false;
                                    pressed6 = false;
                                    pressed7 = false;
                                    pressed8 = false;
                                    pressed5 = !pressed5 ;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                      ShowHomeButtonCatPage( "from home", 95)),
                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/bakery.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Bakery",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 =  false;
                                    pressed2 = false ;
                                    pressed3 = false;
                                    pressed4 = false;
                                    pressed5 = false;
                                    pressed7 = false;
                                    pressed8 = false;
                                    pressed6 = !pressed6 ;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>

                                      ShowHomeButtonCatPage( "from home", 89)),
                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/dairy.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Dairy",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 =  false;
                                    pressed2 = false ;
                                    pressed3 = false;
                                    pressed4 = false;
                                    pressed5 = false;
                                    pressed6 = false;
                                    pressed8 = false;
                                    pressed7 = !pressed7 ;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowHomeButtonCatPage( "from home", 193)),

                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/drinks.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Drinks",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
//                      color: pressed1 ? HexColor("649FC3") : Colors.white ,
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 4 - 30,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pressed1 =  false;
                                    pressed2 = false ;
                                    pressed3 = false;
                                    pressed4 = false;
                                    pressed5 = false;
                                    pressed6 = false;
                                    pressed7 = false;
                                    pressed8 = !pressed8 ;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                      ShowHomeButtonCatPage( "from home", 108)),
                                  );
                                },
                                //padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icons/chicken.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
//                              height: 50.0,
//                              color: pressed1 ? Colors.transparent : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Chicken",
                            style: TextStyle( fontFamily: 'montserrat',
                                color: pressed2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
//              Container(
//                height: 230,
//                child: GridView.count(
//                    crossAxisCount: 4,
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
//                    children: productCategories
//                        .map((String image) => GridTile(
//                            child: GestureDetector(
//                                onTap: () {
//
////                              for (var i = 0; i < productCategories.length; i++) {
////                                print(productCategories[i]);
////                              }
////                                  if (productCategories[0] ==
////                                      'assets/images/icons/fruits.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[1] ==
////                                      'assets/images/icons/vegetables.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[2] ==
////                                      'assets/images/icons/seafood.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[3] ==
////                                      'assets/images/icons/hotSelling.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[4] ==
////                                      'assets/images/icons/bakery.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[5] ==
////                                      'assets/images/icons/dairy.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[6] ==
////                                      'assets/images/icons/drinks.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  } else if (productCategories[7] ==
////                                      'assets/images/icons/chicken.png') {
////                                    Navigator.of(context).push(
////                                        MaterialPageRoute(
////                                            builder: (context) =>
////                                                ShowSearchProductPage(
////                                                    productList:productList,
////                                                    sku:productList.items[0].sku)));
////                                  }
//                                },
//                                child: Image.asset(image, fit: BoxFit.contain))))
//                        .toList()),
//              ),

//            *//*//
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//              height: 373,
//              child: ListView.builder(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                itemCount: bestSellername.length,
//                itemBuilder: (context, index) {
//                  return Builder(
//                    builder: (BuildContext context) {
//                      return Container(
//                        width: 200.0,
//                        height: 315.0,
//                        child: Card(
//                          clipBehavior: Clip.antiAlias,
//                          child: InkWell(
//                            onTap: () {
////                              Navigator.push(
////                                context,
////                                MaterialPageRoute(
////                                    builder: (context) =>
////                                        Products(
////                                            bestSellername[index],
////                                            bestSellerImage[
////                                            index],
////                                            price[index],
////                                            bestSellerDesc[index],
////                                            bestSellerSku[
////                                            index])),
////                              );
//                            },
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                SizedBox(
//                                  height: 160,
//                                  child: Hero(
//                                    tag: Random().nextInt(1000),
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                        // color: const Color(0xff7c94b6),
//                                        color: Colors.white,
//                                        image: DecorationImage(
//                                          image: NetworkImage(
//                                              bestSellerImage[index]
//                                                  .toString()),
//                                          fit: BoxFit.contain,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                Card(
//                                  color: Colors.blue,
//                                  shape: ContinuousRectangleBorder(
//                                    borderRadius: BorderRadius.zero,
//                                  ),
//                                  borderOnForeground: true,
//                                  elevation: 0,
//                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                  child: ListTile(
//                                      title: Text(
//                                    bestSellername[index].replaceRange(
//                                            17,
//                                            bestSellername[index].length,
//                                            '...') +
//                                        "\n" +
//                                        "\n" +
//                                        "AED " +
//                                        price[index].toString(),
//                                    style: TextStyle( fontFamily: 'montserrat',
//                                        color: Colors.black, fontSize: 13.0),
//                                    textAlign: TextAlign.left,
//                                  )),
//                                ),
//                                Card(
//                                  color: Colors.blue,
//                                  shape: ContinuousRectangleBorder(
//                                    borderRadius: BorderRadius.zero,
//                                  ),
//                                  borderOnForeground: true,
//                                  elevation: 0,
//                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                  child: Hero(
//                                    tag: Random().nextInt(1000),
//                                    child: new ButtonTheme(
//                                      child: new ButtonBar(
//                                        alignment: MainAxisAlignment.center,
//                                        children: <Widget>[
//                                          new RaisedButton(
//                                              color: Colors.black,
//                                              child: Text('Buy now',
//                                                  style: TextStyle( fontFamily: 'montserrat',
//                                                      color: Colors.white,
//                                                      fontSize: 10.0)),
//                                              onPressed: () async {
//                                                // cartListItems = [] ;
//                                                await addCartUser(
//                                                    trendingSku[index]);
//                                                await getUserCartList();
//                                                // await getUserCartList();
////                                                Navigator.push(
////                                                  context,
////                                                  MaterialPageRoute(
////                                                      builder: (context) => Shop(
////                                                          cartListItems,
////                                                          imageUrls,
////                                                          grandTotal,
////                                                          subTotal,
////                                                          vat)),
////                                                );
//                                              }),
//                                          new OutlineButton(
//                                              borderSide: BorderSide(
//                                                  color: Colors.black),
//                                              color: Theme.of(context)
//                                                  .primaryColor,
//                                              child: Text('Add to cart',
//                                                  style: TextStyle( fontFamily: 'montserrat',
//                                                      color: Colors.white,
//                                                      fontSize: 10.0)),
//                                              onPressed: () async {
//                                                if (!isLogin) {
//                                                  //  await addCartGuest(bestSellerSku[index]);
//                                                  await addCartUser(
//                                                      bestSellerSku[index]);
////                                                  Navigator.push(
////                                                    context,
////                                                    MaterialPageRoute(
////                                                        builder:
////                                                            (context) =>
////                                                            CartList()),
////                                                  );
//                                                }
//                                              }),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      );
//                    },
//                  );
//                },
//              ),
//            ),

//            Container(
//              child: FutureBuilder(
////                future: _wallpaperApiService.getWallpaperFromApi,
////              future: getTrendingProducts2(),
//                builder: (BuildContext context,
//                    AsyncSnapshot<List<TrendingProductModel>> snapshot) {
//                  switch (snapshot.connectionState) {
//                    case ConnectionState.none:
//                      return Container(
//                        child: Center(
//                          child: CircularProgressIndicator(),
//                        ),
//                      );
//                      break;
//                    case ConnectionState.waiting:
//                      return Container(
//                        child: Center(
//                          child: CircularProgressIndicator(),
//                        ),
//                      );
//                      break;
//                    case ConnectionState.active:
//                      return Container(
//                        child: Center(
//                          child: CircularProgressIndicator(),
//                        ),
//                      );
//                      break;
//                    case ConnectionState.done:
//                      if (snapshot.hasError) {
//                        return Container(
//                          child: Center(
//                            child: Text("Something Wrong"),
//                          ),
//                        );
//                      } else {
//                        return Center(
//                          child: Text(
//                            "This is Api Data",
//                            style: TextStyle( fontFamily: 'montserrat', color: Colors.black),
//                          ),
//                        );
//                      }
//                      break;
//                  }
//                  return Container();
//                },
//              ),
//            ),

//            Padding(
//              padding: EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
//              child: Text(('Trending Products'),
//                  style: TextStyle( fontFamily: 'montserrat',
//                      color: Colors.black,
//                      fontSize: 18,
//                      fontWeight: FontWeight.w700)),
//            ),
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//              height: 373,
//              child: ListView.builder(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
////                itemCount: trendingProductName.length,
//                itemBuilder: (context, index) {
//                  return Builder(
//                    builder: (BuildContext context) {
//                      return Container(
//                        width: 200.0,
//                        height: 315.0,
//                        child: Card(
//                          clipBehavior: Clip.antiAlias,
//                          child: InkWell(
//                            onTap: () {
////                                        Navigator.pushNamed(
////                                            context, '/products',
////                                            arguments: i);
////                              Navigator.push(
////                                context,
////                                MaterialPageRoute(
////                                    builder: (context) =>
////                                        Products(
////                                            trendingProductName[
////                                            index],
////                                            trendingProductImage[
////                                            index],
////                                            (trendingProductPrice[
////                                            index] +
////                                                0.0),
////                                            trendingDesc[index],
////                                            trendingSku[index])),
////                              );
//                            },
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                SizedBox(
//                                  height: 160,
//                                  child: Hero(
//                                    tag: Random().nextInt(1000),
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                        // color: const Color(0xff7c94b6),
//                                        color: Colors.white,
//                                        image: DecorationImage(
//                                          image: NetworkImage(
//                                              trendingProductImage[index]
//                                                  .toString()),
//                                          fit: BoxFit.contain,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                Card(
//                                  color: Colors.blue,
//                                  shape: ContinuousRectangleBorder(
//                                    borderRadius: BorderRadius.zero,
//                                  ),
//                                  borderOnForeground: true,
//                                  elevation: 0,
//                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                  child: ListTile(
//                                      title: Text(
//                                    trendingProductName[index].length > 16
//                                        ? trendingProductName[index]
//                                                .replaceRange(
//                                                    17,
//                                                    trendingProductName[index]
//                                                        .length,
//                                                    '...') +
//                                            "\n" +
//                                            "\n" +
//                                            "AED " +
//                                            trendingProductPrice[index]
//                                                .toString()
//                                        : trendingProductName[index] +
//                                            "\n" +
//                                            "\n" +
//                                            "AED " +
//                                            trendingProductPrice[index]
//                                                .toString(),
//                                    style: TextStyle( fontFamily: 'montserrat',
//                                        color: Colors.black, fontSize: 13.0),
//                                    textAlign: TextAlign.left,
//                                  )),
//                                ),
//                                Card(
//                                  color: Colors.blue,
//                                  shape: ContinuousRectangleBorder(
//                                    borderRadius: BorderRadius.zero,
//                                  ),
//                                  borderOnForeground: true,
//                                  elevation: 0,
//                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                  child: new ButtonTheme(
//                                    child: new ButtonBar(
//                                      alignment: MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        new RaisedButton(
//                                            color: Colors.black,
//                                            child: Text('Buy now',
//                                                style: TextStyle( fontFamily: 'montserrat',
//                                                    color: Colors.black,
//                                                    fontSize: 10.0)),
//                                            onPressed: () async {
//                                              await addCartUser(
//                                                  trendingSku[index]);
//                                              await getUserCartList();
////                                              Navigator.push(
////                                                context,
////                                                MaterialPageRoute(
////                                                    builder: (context) => Shop(
////                                                        cartListItems,
////                                                        imageUrls,
////                                                        grandTotal,
////                                                        subTotal,
////                                                        vat)),
////                                              );
//                                            }),
//                                        new OutlineButton(
//                                            borderSide:
//                                                BorderSide(color: Colors.black),
//                                            color:
//                                                Theme.of(context).primaryColor,
//                                            child: Text('Add to cart',
//                                                style: TextStyle( fontFamily: 'montserrat',
//                                                    color: Colors.black,
//                                                    fontSize: 10.0)),
//                                            onPressed: () async {
//                                              if (!isLogin) {
//                                                // await  addCartGuest(trendingSku[index]);
//                                                await addCartUser(
//                                                    trendingSku[index]);
////                                                Navigator.push(
////                                                  context,
////                                                  MaterialPageRoute(
////                                                      builder:
////                                                          (context) =>
////                                                          CartList()),
////                                                );
//                                              }
//                                            }),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      );
//                    },
//                  );
//                },
//              ),
//            ),
//
//            FutureBuilder<dynamic>(
//              future: getTrendingProducts2(), // async work
//              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.waiting: return Text('Loading....');
//                  default:
//                    if (snapshot.hasError)
//                      return Text('Error: ${snapshot.error}');
//                    else
//                            return Text('Result: ${snapshot.data}');
////                      return Text('Result: ${snapshot.data['items'][0]['name']}');
//                }
//              },
//            ),

//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
//              height: 262,
//              child: ListView.builder(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                itemCount: productList.items.length,
//                itemBuilder: (context, index) {
//                  return Builder(
//                    builder: (BuildContext context) {
//                      return Container(
//                        width: MediaQuery.of(context).size.width / 3 + 45,
//                        height: 220.0,
//                        child: Card(
//                          clipBehavior: Clip.antiAlias,
//                          child: InkWell(
//                            onTap: () {
//                              print("clicked product");
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (context) => Products(
//                                        productList,
//                                        index,
//                                        productList.items[index].sku),
//                                  ));
////
//                            },
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                SizedBox(
//                                  height: 115,
//                                  child: Hero(
//                                    tag: Random().nextInt(1000),
//                                    child:
////                                        ClipRRect(
////                                          borderRadius: BorderRadius.circular(15.0),
////                                          child:
////                                          CachedNetworkImage(
////                                            fit: BoxFit.fill,
////
////                                            imageUrl: "https://aswaqrak.ae/pub/media/catalog/product" + productList.items[index].mediaGalleryEntries[0].file,
////                                            placeholder: (context, url) => Center(
////                                                child: CircularProgressIndicator()
////                                            ),
////                                            errorWidget: (context, url, error) => Image(
////                                              fit: BoxFit.fill,
////                                              image: AssetImage('assets/images/banner-1.png'),
////                                            ),
////
////                                          ),
////                                        ),
//                                        Container(
//                                            decoration: BoxDecoration(
//                                              // color: const Color(0xff7c94b6),
//                                              color: Colors.white,
//                                              image: DecorationImage(
//                                                image: NetworkImage(
////                                                    "https://aswaqrak.ae/pub/media/catalog/product" +
////                                                        productList
////                                                            .items[index]
////                                                            .mediaGalleryEntries[
////                                                                0]
////                                                            .file
//                                                "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475/1/1/1150001872.jpg"
//                                                ),
//                                                fit: BoxFit.fill,
//                                              ),
//                                            ),
//                                            child: new Stack(
//                                              children: <Widget>[
//                                                new Positioned(
//                                                  right: 15.0,
//                                                  top: 15.0,
//                                                  child: Image.asset(
//                                                      'assets/images/heart.png',
//                                                      height: 15.0),
//                                                ),
//                                                new Positioned(
//                                                  right: 42.0,
//                                                  top: 15.0,
//                                                  child: Image.asset(
//                                                      'assets/images/flag.png',
//                                                      height: 15.0),
//                                                ),
//                                                new Positioned(
//                                                  left: 15.0,
//                                                  top: 15.0,
//                                                  child: new Icon(
//                                                    Icons.star,
//                                                    color: Colors.orange,
//                                                    size: 15.0,
//                                                  ),
//                                                ),
//                                                new Positioned(
//                                                  left: 32.0,
//                                                  top: 16.0,
//                                                  child: new Text(
//                                                    '4.2',
//                                                    style: new TextStyle( fontFamily: 'montserrat',
//                                                      fontWeight:
//                                                          FontWeight.bold,
//                                                      fontSize: 12.0,
//                                                    ),
//                                                  ),
//                                                ),
//                                              ],
//                                            )),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 10,
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 0.0),
//                                  child: Align(
//                                    alignment: Alignment.center,
//                                    child: Flexible(
//                                      child: Text(
//                                        productList.items[index].name,
//                                        overflow: TextOverflow.ellipsis,
//                                        textAlign: TextAlign.center,
//                                        style: TextStyle( fontFamily: 'montserrat',
//                                            color: Colors.black,
//                                            fontWeight: FontWeight.w500,
//                                            fontSize: 14),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 0.0),
//                                  child: Align(
//                                    alignment: Alignment.center,
//                                    child: RichText(
//                                      overflow: TextOverflow.ellipsis,
//                                      text: TextSpan(
//                                        text: 'SAR ',
//                                        style: TextStyle( fontFamily: 'montserrat',
//                                            color: Colors.black,
//                                            fontWeight: FontWeight.w500,
//                                            fontSize: 14),
//                                        /*defining default style is optional */
//                                        children: <TextSpan>[
//                                          TextSpan(
//                                              text: productList
//                                                  .items[index].price
//                                                  .toString(),
//                                              style: TextStyle( fontFamily: 'montserrat',
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 16)),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//
////
//                                Padding(
//                                  padding: EdgeInsets.only(top: 0.0),
//                                  child: Align(
//                                    alignment: Alignment.center,
//                                    child: RichText(
//                                      overflow: TextOverflow.ellipsis,
//                                      text: TextSpan(
//                                        text: 'Pieces: 12 pcs',
//                                        style: TextStyle( fontFamily: 'montserrat',
//                                            color: Colors.grey,
//                                            fontWeight: FontWeight.w400,
//                                            fontSize: 10),
//                                        /*defining default style is optional */
//                                        children: <TextSpan>[
//                                          TextSpan(
//                                              text: ' | ',
//                                              style: TextStyle( fontFamily: 'montserrat',
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 10)),
//                                          TextSpan(
//                                              text: 'Net wt: ' +
//                                                  productList
//                                                      .items[index].weight
//                                                      .toString() +
//                                                  "gm",
//                                              style: TextStyle( fontFamily: 'montserrat',
//                                                  color: Colors.grey,
//                                                  fontWeight: FontWeight.w400,
//                                                  fontSize: 10)),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//
//                                Padding(
//                                  padding: EdgeInsets.symmetric(horizontal: 2),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
////                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.only(top: 5.0, right: 0),
//                                        child: Column(
//                                          children: <Widget>[
//                                            SizedBox(
//                                              height: 17,
//                                            ),
////                                            SizedBox(
////                                              width: 65,
////                                              child:
////                                              NumberInputPrefabbed
////                                                  .squaredButtons(
////                                                scaleHeight: 0.6,
////                                                scaleWidth: 0.9,
////                                                incDecBgColor:
////                                                Colors.white,
////                                                controller:
////                                                TextEditingController(),
////                                                min: 1,
////                                                max: 50,
////                                              ),
////                                            ),
//                                          ],
//                                        ),
//                                      ),
//
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.only(top: 0.0, right: 0),
//                                        child: SizedBox(
//                                          width: MediaQuery.of(context)
//                                                      .size
//                                                      .width /
//                                                  3 -
//                                              50,
//                                          child: RaisedButton(
////                                              color:
////                                              HexColor("649FC3"),
//                                              child: Text('Add to cart',
//                                                  style: TextStyle( fontFamily: 'montserrat',
//                                                      color: Colors.white,
//                                                      fontSize: 10.0)),
//                                              onPressed: () async {
//                                                if (!isLogin) {
//                                                  await addCartGuest(productList
//                                                      .items[index].sku);
////
////                                                        Navigator.push(
////                                                          context,
////                                                          MaterialPageRoute(builder: (context) => CartList()),
////                                                        );
//                                                } else {
//                                                  await addCartUser(productList
//                                                      .items[index].sku);
////                                                        Navigator.push(
////                                                          context,
////                                                          MaterialPageRoute(builder: (context) => CartList()),
////                                                        );
//                                                }
////                                                      await addCartUser(productList.items[index].sku);
////
//                                              }),
//                                        ),
//                                      ),
////
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      );
//                    },
//                  );
//                },
//              ),
//            ),
            verticalSpace(),
            verticalSpace(),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
              child: Column(
                children: [
                  listviewHeader(
                      leftTitle: "BEST DEALS", rightTitle: "See All",   onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowSearchProductPage(
                                  categoryId: 79, name: "All")),
                    );
                  },),
                  verticalSpace(),
                  Container(

//                    height: MediaQuery.of(context).size.height*.4,
                    padding: EdgeInsets.only(bottom: 0),
                    height: 280,
//                      width: 100,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 10,bottom: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.items.length,
                      itemBuilder: (context, index) {
//                        var configPrice ;
//                        if(productList.items[index].typeId == "configurable"){
//                          getProductPrice(productList.items[index].sku).then((price) {
//                            setState(() {
//                              configPrice = price;
//                            });
//
//                          }
//                          );
//                        }
                        return Row(
                          children: [
                            InkWell(
                              onTap: () async {
//                                var price = await getProductPrice(productList.items[index].sku);
//                                price = price + .0;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),
                                    productList.items[index].typeId == "configurable" ? Products(productList, index,
                                            productList.items[index].sku, productPrice[index], "configurable") :  Products(productList, index,
                                        productList.items[index].sku, productList.items[index].price, "normal"),
                                  ),
                                );
                              },
                              child: Card(
//                                color: Colors.white,
                                color: Colors.white,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
//                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
//                                        Container(
//                                          height: 200,
//                                          width: 200,
//                                          child: CachedNetworkImage(
//                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
//                                                productList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,
//                                            fit: BoxFit.fill,height: 100,
//                                            width: 200,
//                                          ),
//                                        ),
                                        Container(
                                          width: 160,
                                          height: 120,
                                          child: CachedNetworkImage(
//                                          width: 200,
                                            fit: BoxFit.contain,
                                            imageUrl: productList
                                                .items[index]
                                                .mediaGalleryEntries.length > 0 ?
                                                "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                    productList
                                                        .items[index]
                                                        .mediaGalleryEntries[
                                                            0]
                                                        .file : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                            placeholder: (context, url) => Center(
                                                child:
//                                                Image.asset(
//                                                  'assets/images/logo.png',
//                                                  height: 35,
//                                                ),),
//                                            errorWidget:
//                                                (context, url, error) =>
//                                                    new Icon(Icons.error),
                        SpinKitPulse(
                        color: Colors.red,
                        size: 50.0,
                        ),
                                          ),
                                        ),
//                                        Container(
//                                          height: 200,
////                                            decoration: BoxDecoration(
////                                            ),
//                                          child: Image.network(
//                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
//                                                +
//                                                widget.productList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,fit: BoxFit.fill,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10.0,
//                                          left: 5.0,
//                                          child: Image.asset(
//                                            'assets/images/icons/save.png',
//                                            height: 15,
//                                            fit: BoxFit.contain,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10.0,
//                                          right: 5.0,
//                                          child: Image.asset(
//                                            'assets/images/icons/love.png',
//                                            height: 15,
////                                        color: Colors.white,
//                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        productList.items[index].typeId == "configurable" ?    Text(
                                          'AED ' +
                                             productPrice[index].toString(),
                                          style:  TextStyle( fontFamily: 'montserrat',
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),

                                        ) : Text(
                                          'AED ' +
                                              productList.items[index].price.toString(),
                                          style:  TextStyle( fontFamily: 'montserrat',
                                              fontSize: 14,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),

                                        ),

                                      ],
                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),

//                                    Flexible(
//                                      child: Container(
//                                        width: 100,
//                                        height: 25,
//                                        padding: EdgeInsets.only(
//                                            left: 5,
//                                            right: 5,
//                                            top: 5,
//                                            bottom: 5),
//                                        child:
                                    SizedBox(
                                      width: 160,
                                      height: 44,
                                      child:  Text(
                                        productList.items[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
//                                      ),
//                                    ),
                                    ),

                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 25.0,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            .4,
                                        // fixed width and height
                                        child:
                                            NumberInputWithIncrementDecrement(
                                          controller: TextEditingController(),
                                          initialValue: 1,
                                          min: 1,
                                          max: 100,
                                          onIncrement: (num newVal) {
                                            setState(() {
                                              productqty[index] = newVal;
                                            });
                                          },
                                          onDecrement:
                                              (num newlyDecrementedValue) {
                                            setState(() {
                                              productqty[index] =
                                                  newlyDecrementedValue;
                                            });
                                          },
                                          numberFieldDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          decIconColor: HexColor("e25814"),
                                          widgetContainerDecoration:
                                              BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(1)),
                                                  border: Border.all(
                                                    color: Colors.black26,
                                                    width: 0.5,
                                                  )),
                                          incIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                            ),
                                          ),
                                          separateIcons: false,
                                          decIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                            ),
                                          ),
                                          incIconSize: 15,
                                          decIconSize: 15,
                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
                                              decIcon: Icons.remove,
                                          incIcon: Icons.add, incIconColor: HexColor("302c98"),

                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 27,
                                      width:
                                          MediaQuery.of(context).size.width *
                                              .37,
                                      decoration: BoxDecoration(
                                            color: HexColor("302c98"),
                                        borderRadius:
                                            BorderRadius.circular(3),
                                        border: Border.all(
                                            width: 0.5, color: HexColor("302c98")),
                                      ),
                                      child: FlatButton(
                                          onPressed: () async {
                                            if (!HomePageState.isLogin) {
                                              await addCartGuest(
                                                  productList
                                                      .items[index].sku,
                                                  productqty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            } else {
                                              await addCartUser(
                                                  productList
                                                      .items[index].sku,
                                                  productqty[index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            }
//                                                    await addCartUser(productList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                                          },
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle( fontFamily: 'montserrat',
                                                color:Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),


                  GestureDetector(
                      onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowHomeButtonCatPage("from home",87,
                                )),
                      );
                    },
                    child: CachedNetworkImage(
//                                          width: 200,
                      fit: BoxFit.contain,
                      imageUrl: offerBannerList[0],
                      placeholder: (context, url) => Center(
                        child:
                        SpinKitPulse(
                          color: Colors.red,
                          size: 50.0,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(),


                  listviewHeader(
                    leftTitle: "HEALTH CARE ESSENTIALS", rightTitle: "See All",onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowSearchProductPage(
                                  categoryId: 87, name: "All")),
                    );
                  },),
                  verticalSpace(),

                  verticalSpace(),

                  popularList.items.length > 0 ?  Container(
                    height: 280,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 10,bottom: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: popularList.items.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                  Products(popularList, index,
                                        popularList.items[index].sku, popularList.items[index].price, "normal"),


                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
//                                color: Color(0xFFFAFAFA),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
//                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 160,
                                          height: 120,
                                          child: CachedNetworkImage(
//                                          width: 200,
                                            fit: BoxFit.contain,
                                            imageUrl: popularList
                                                .items[index]
                                                .mediaGalleryEntries.length > 0 ?
                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                popularList
                                                    .items[index]
                                                    .mediaGalleryEntries[
                                                0]
                                                    .file : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                            placeholder: (context, url) => Center(
                                              child:
//                                                Image.asset(
//                                                  'assets/images/logo.png',
//                                                  height: 35,
//                                                ),),
//                                            errorWidget:
//                                                (context, url, error) =>
//                                                    new Icon(Icons.error),
                                              SpinKitPulse(
                                                color: Colors.red,
                                                size: 50.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'AED ' +
                                              popularList.items[index].price
                                                  .toString(),
                                          style:  TextStyle( fontFamily: 'montserrat',
                                              fontSize: 14,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),

                                        ),
                                      ],
                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),
//                                    Flexible(
//                                      child: Container(
//                                        width: 100,
//                                        padding: EdgeInsets.only(
//                                            left: 5,
//                                            right: 5,
//                                            top: 5,
//                                            bottom: 5),
//                                        child:
                                    SizedBox(
                                      width: 160,
                                      height: 44,
                                      child:  Text(
                                        popularList.items[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),

//                                      ),
//                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 25.0,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .4,
                                        // fixed width and height
                                        child:
                                        NumberInputWithIncrementDecrement(
                                          controller: TextEditingController(),
                                          initialValue: 1,
                                          min: 1,
                                          max: 100,
                                          onIncrement: (num newVal) {
                                            setState(() {
                                              popularqty[index] = newVal;
                                            });
                                          },
                                          onDecrement:
                                              (num newlyDecrementedValue) {
                                            setState(() {
                                              popularqty[index] =
                                                  newlyDecrementedValue;
                                            });
                                          },
                                          numberFieldDecoration:
                                          InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          decIconColor: HexColor("e25814"),
                                          widgetContainerDecoration:
                                          BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(1)),
                                              border: Border.all(
                                                color: Colors.black26,
                                                width: 0.5,
                                              )),
                                          incIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                            ),
                                          ),
                                          separateIcons: false,
                                          decIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                            ),
                                          ),
                                          incIconSize: 15,
                                          decIconSize: 15,
                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
                                          incIcon: Icons.add,incIconColor: HexColor("302c98"),
                                          decIcon: Icons.remove,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 27,
                                      width:
                                      MediaQuery.of(context).size.width *
                                          .37,
                                      decoration: BoxDecoration(
                                        color: HexColor("302c98"),
                                        borderRadius:
                                        BorderRadius.circular(3),
                                        border: Border.all(
                                            width: 0.5, color: HexColor("9ba905")),
                                      ),
                                      child: FlatButton(
                                          onPressed: () async {
                                            if (!isLogin) {
                                              await addCartGuest(
                                                  popularList
                                                      .items[index].sku,
                                                  popularqty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            } else {
                                              await addCartUser(
                                                  popularList
                                                      .items[index].sku,
                                                  popularqty[index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            }
//                                                    await addCartUser(productList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                                          },
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle( fontFamily: 'montserrat',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ) : Container(),

                  listviewHeader(
                    leftTitle: "FRESH FOODS",
                    rightTitle: "",onTap: () {

                  },),
                  verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowSearchProductPage(
                                        categoryId: 99, name: "Fruits & Vegetables")),
                          );
                        },
                        child:
                        CachedNetworkImage(
                                         width: MediaQuery.of(context).size.width * .47,
                          height: 150,
                          fit: BoxFit.contain,
                          imageUrl: categoryBannerList[0],
                          placeholder: (context, url) => Center(
                            child:
                            SpinKitPulse(
                              color: Colors.red,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowSearchProductPage(
                                              categoryId: 103, name: "Paultry and Meat")),

                                );
                              },
                              child:  CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * .48,
                                height: 73,
                                fit: BoxFit.contain,
                                imageUrl: categoryBannerList[1],
                                placeholder: (context, url) => Center(
                                  child:
                                  SpinKitPulse(
                                    color: Colors.red,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowSearchProductPage(
                                              categoryId: 95, name: "Bakery")),

                                );
                              },
                              child:  CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * .48,
                                height: 73,
                                fit: BoxFit.contain,
                                imageUrl: categoryBannerList[2],
                                placeholder: (context, url) => Center(
                                  child:
                                  SpinKitPulse(
                                    color: Colors.red,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )





                    ],
                  ),
                  verticalSpace(),

                  verticalSpace(),
                  listviewHeader(
                      leftTitle: "HOUSEHOLD and KITCHEN ESSENTIALS",
                      rightTitle: "See All",onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowSearchProductPage(
                                  categoryId: 1516, name: "All")),
                    );
                  },),
                  verticalSpace(),

                  Container(
//                      height: MediaQuery.of(context).size.height * .3,
                    height: 260,
//                      width: 100,

                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 10,bottom: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bestSellingList.items.length,
//                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                          crossAxisCount: 3,
////                  childAspectRatio: 16 / 20,
//                          childAspectRatio: 14/20,
//                          crossAxisSpacing: 1,
//                          mainAxisSpacing: 1,
//
//                        ),
                      itemBuilder: (context, index) {
//                          return Container(
//                            height: 50,
//                            width: 200,
//                            color: Colors.amber[colorCodes[index]],
//                            child:
//                                Center(child: Text('Entry ${entries[index]}')),
//                          );
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),

                                Products(bestSellingList, index,
                                    bestSellingList.items[index].sku, bestSellingList.items[index].price, "normal"),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
//                                color: Color(0xFFFAFAFA),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
//                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
//
                                        Container(
//                                    width: 100,
                                          height: 100,
                                          child: CachedNetworkImage(
//                                          width: 200,
                                            width: 120,
                                            height: 100,
                                            fit: BoxFit.contain,
                                            imageUrl: bestSellingList
                                                .items[index]
                                                .mediaGalleryEntries.length > 0 ?
                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                bestSellingList
                                                    .items[index]
                                                    .mediaGalleryEntries[
                                                0]
                                                    .file : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                            placeholder: (context, url) => Center(
                                              child:
//                                                Image.asset(
//                                                  'assets/images/logo.png',
//                                                  height: 35,
//                                                ),),
//                                            errorWidget:
//                                                (context, url, error) =>
//                                                    new Icon(Icons.error),
                                              SpinKitPulse(
                                                color: Colors.red,
                                                size: 50.0,
                                              ),
                                            ),
                                        ),
//                                        Container(
//                                          height: 200,
////                                            decoration: BoxDecoration(
////                                            ),
//                                          child: Image.network(
//                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
//                                                +
//                                                widget.productList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,fit: BoxFit.fill,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10.0,
//                                          left: 5.0,
//                                          child: Image.asset(
//                                            'assets/images/icons/save.png',
//                                            height: 15,
//                                            fit: BoxFit.contain,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10.0,
//                                          right: 5.0,
//                                          child: Image.asset(
//                                            'assets/images/icons/love.png',
//                                            height: 15,
////                                        color: Colors.white,
//                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'AED ' +
                                              bestSellingList.items[index].price
                                                  .toString(),
                                          style:  TextStyle( fontFamily: 'montserrat',
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),

                                        ),
//                                        Text(
//                                          '/kg',
//                                          style: GoogleFonts.openSans(
//                                            textStyle: TextStyle( fontFamily: 'montserrat',
//                                              fontSize: 12,
//                                              color: Colors.black87,
//                                            ),
//                                          ),
//                                        ),
                                      ],
                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),
                                    SizedBox(
                                      width: 160,
                                      height: 44,
                                      child:   Text(
                                        bestSellingList.items[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
//                                      overflow: TextOverflow.clip,
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 25.0,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .4,
                                        // fixed width and height
                                        child:
                                        NumberInputWithIncrementDecrement(
                                          controller: TextEditingController(),
                                          initialValue: 1,
                                          min: 1,
                                          max: 100,
                                          onIncrement: (num newVal) {
                                            setState(() {
                                              bestSellingqty[index] = newVal;
                                            });
                                          },
                                          onDecrement:
                                              (num newlyDecrementedValue) {
                                            setState(() {
                                              bestSellingqty[index] =
                                                  newlyDecrementedValue;
                                            });
                                          },
                                          numberFieldDecoration:
                                          InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          decIconColor: HexColor("e25814"),
                                          widgetContainerDecoration:
                                          BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(1)),
                                              border: Border.all(
                                                color: Colors.black26,
                                                width: 0.5,
                                              )),
                                          incIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                            ),
                                          ),
                                          separateIcons: false,
                                          decIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                            ),
                                          ),
                                          incIconSize: 15,
                                          decIconSize: 15,
                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
                                          incIcon: Icons.add,incIconColor: HexColor("302c98"),
                                          decIcon: Icons.remove,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 27,
                                      width:
                                          MediaQuery.of(context).size.width *
                                              .37,
                                      decoration: BoxDecoration(
                                            color: HexColor("302c98"),
                                        borderRadius:
                                            BorderRadius.circular(3),
                                        border: Border.all(
                                            width: 0.5, color: HexColor("302c98")),
                                      ),
                                      child: FlatButton(
                                          onPressed: () async {
                                            if (!HomePageState.isLogin) {
                                              await addCartGuest(
                                                  bestSellingList
                                                      .items[index].sku,
                                                  bestSellingqty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            } else {
                                              await addCartUser(
                                                  bestSellingList
                                                      .items[index].sku,
                                                  bestSellingqty[index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            }
//                                                    await addCartUser(productList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                                          },
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle( fontFamily: 'montserrat',
                                                color:Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowSearchProductPage(
                                        categoryId: 89, name: "Diary Products")),

                          );
                        },
                        child:  CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * .48,
                          height: 73,
                          fit: BoxFit.contain,
                          imageUrl: categoryBannerList[3],
                          placeholder: (context, url) => Center(
                            child:
                            SpinKitPulse(
                              color: Colors.red,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowSearchProductPage(
                                        categoryId: 1182, name: "Delicatessen")),

                          );
                        },
                        child:  CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * .48,
                          height: 73,
                          fit: BoxFit.contain,
                          imageUrl: categoryBannerList[4],
                          placeholder: (context, url) => Center(
                            child:
                            SpinKitPulse(
                              color: Colors.red,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(),
                  verticalSpace(),
                  listviewHeader(
                    leftTitle: "TOP SELLING PERSONAL CARE",
                    rightTitle: "See All",onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowSearchProductPage(
                                  categoryId: 1517, name: "All")),
                    );
                  },),
                  verticalSpace(),

                  Container(
//                      height: MediaQuery.of(context).size.height * .3,
                    height: 260,
//                      width: 100,

                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 10,bottom: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: topSellingList.items.length,
//                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                          crossAxisCount: 3,
////                  childAspectRatio: 16 / 20,
//                          childAspectRatio: 14/20,
//                          crossAxisSpacing: 1,
//                          mainAxisSpacing: 1,
//
//                        ),
                      itemBuilder: (context, index) {
//                          return Container(
//                            height: 50,
//                            width: 200,
//                            color: Colors.amber[colorCodes[index]],
//                            child:
//                                Center(child: Text('Entry ${entries[index]}')),
//                          );
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
//                                            Products("1","1",2.0, "1","1"),

                                    Products(topSellingList, index,
                                        topSellingList.items[index].sku, topSellingList.items[index].price, "normal"),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
//                                color: Color(0xFFFAFAFA),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
//                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
//
                                        Container(
//                                    width: 100,
                                          height: 100,
                                          child: CachedNetworkImage(
//                                          width: 200,
                                            width: 120,
                                            height: 100,
                                            fit: BoxFit.contain,
                                            imageUrl: topSellingList
                                                .items[index]
                                                .mediaGalleryEntries.length > 0 ?
                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                                topSellingList
                                                    .items[index]
                                                    .mediaGalleryEntries[
                                                0]
                                                    .file : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                            placeholder: (context, url) => Center(
                                              child:
//                                                Image.asset(
//                                                  'assets/images/logo.png',
//                                                  height: 35,
//                                                ),),
//                                            errorWidget:
//                                                (context, url, error) =>
//                                                    new Icon(Icons.error),
                                              SpinKitPulse(
                                                color: Colors.red,
                                                size: 50.0,
                                              ),
                                            ),
                                          ),
//                                        Container(
//                                          height: 200,
////                                            decoration: BoxDecoration(
////                                            ),
//                                          child: Image.network(
//                                            "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475"
//                                                +
//                                                widget.productList
//                                                    .items[index]
//                                                    .mediaGalleryEntries[0]
//                                                    .file,fit: BoxFit.fill,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10.0,
//                                          left: 5.0,
//                                          child: Image.asset(
//                                            'assets/images/icons/save.png',
//                                            height: 15,
//                                            fit: BoxFit.contain,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10.0,
//                                          right: 5.0,
//                                          child: Image.asset(
//                                            'assets/images/icons/love.png',
//                                            height: 15,
////                                        color: Colors.white,
//                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'AED ' +
                                              topSellingList.items[index].price
                                                  .toString(),
                                          style:  TextStyle( fontFamily: 'montserrat',
                                              fontSize: 14,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),

                                        ),
//                                        Text(
//                                          '/kg',
//                                          style: GoogleFonts.openSans(
//                                            textStyle: TextStyle( fontFamily: 'montserrat',
//                                              fontSize: 12,
//                                              color: Colors.black87,
//                                            ),
//                                          ),
//                                        ),
                                      ],
                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10,right: 10),
//                                      child:
//                                    ),
                                    SizedBox(
                                      width: 160,
                                      height: 44,
                                      child:   Text(
                                        topSellingList.items[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
//                                      overflow: TextOverflow.clip,
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 25.0,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .4,
                                        // fixed width and height
                                        child:
                                        NumberInputWithIncrementDecrement(
                                          controller: TextEditingController(),
                                          initialValue: 1,
                                          min: 1,
                                          max: 100,
                                          onIncrement: (num newVal) {
                                            setState(() {
                                              hotProductQty[index] = newVal;
                                            });
                                          },
                                          onDecrement:
                                              (num newlyDecrementedValue) {
                                            setState(() {
                                              hotProductQty[index] =
                                                  newlyDecrementedValue;
                                            });
                                          },
                                          numberFieldDecoration:
                                          InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          decIconColor: HexColor("e25814"),
                                          widgetContainerDecoration:
                                          BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(1)),
                                              border: Border.all(
                                                color: Colors.black26,
                                                width: 0.5,
                                              )),
                                          incIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                            ),
                                          ),
                                          separateIcons: false,
                                          decIconDecoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                            ),
                                          ),
                                          incIconSize: 15,
                                          decIconSize: 15,
                                          style: TextStyle( fontFamily: 'montserrat', fontSize: 15),
                                          incIcon: Icons.add,incIconColor: HexColor("302c98"),
                                          decIcon: Icons.remove,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 27,
                                      width:
                                      MediaQuery.of(context).size.width *
                                          .37,
                                      decoration: BoxDecoration(
                                        color: HexColor("302c98"),
                                        borderRadius:
                                        BorderRadius.circular(3),
                                        border: Border.all(
                                            width: 0.5, color: HexColor("302c98")),
                                      ),
                                      child: FlatButton(
                                          onPressed: () async {
                                            if (!HomePageState.isLogin) {
                                              await addCartGuest(
                                                  topSellingList
                                                      .items[index].sku,
                                                  hotProductQty[index]);
//
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            } else {
                                              await addCartUser(
                                                  topSellingList
                                                      .items[index].sku,
                                                  hotProductQty[index]);
//                                                      Navigator.push(
//                                                        context,
//                                                        MaterialPageRoute(builder: (context) => CartList()),
//                                                      );
                                            }
//                                                    await addCartUser(productList.items[index].sku);
//                                                    Navigator.push(
//                                                      context,
//                                                      MaterialPageRoute(builder: (context) => CartList()),
//                                                    );
                                          },
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle( fontFamily: 'montserrat',
                                                color:Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),


                  verticalSpace(),
                  verticalSpace(),

                ],
              ),
            ),
            verticalSpace(),

          ],
        ),
      )

          :

      Container(

        decoration: BoxDecoration(           )      ,
        child: Center(
            child: Column(
//            mainAxisAlignment: ,
              children: [

                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text("Oops! \nInternet Connection \nis not detected! " ,
                          style:  TextStyle( fontFamily: 'montserrat',
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold ),
                           textAlign: TextAlign.center,
                         ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Please check your network connection." ,
                          style:  TextStyle( fontFamily: 'montserrat',
                               color: HexColor("302c98"),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width:
                          MediaQuery.of(context).size.width *
                              .8,
                          decoration: BoxDecoration(
                            color: HexColor("302c98"),
                            borderRadius:
                            BorderRadius.circular(3),
                            border: Border.all(
                                width: 0.5, color: HexColor("302c98")),
                          ),
                          child: FlatButton(
                              onPressed: () async {
                                var connectivityResult = await (Connectivity()
                                    .checkConnectivity());
                                if (connectivityResult == ConnectivityResult.none) {
                                  setState(() {
                                    _progressController = false;
                                    isnetworkAvailable = false;
                                  });
                                  print("no internet");

                                } else {
                                  setState(() {
                                    _progressController = true;
                                    isnetworkAvailable = true;
                                  });
                                  isLoggedIn();
                                  loadBanner();
                                  loadCategoryBanner();
                                  loadCoupenBanner();
//    freshFoodBanner();
                                  getProductList();

                                  getBestSellingList();
                                  getHealthcareProduct();
                                  listenForAdminKey();
                                }

                              },
                              child: Text(
                                'Try Again',
                                style: TextStyle( fontFamily: 'montserrat',
                                    color:Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                        ),
                      ],
                    )
                  ),
                ),

              ],
            )


        ),
      ),
    );
  }

  Future loadBanner() async {
    var url ='https://aswaqrak.ae/rest/V1/cmsBlock/26';
    try {
      print(url);
      var response = await http.get(url,
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
//        print("banner response");
//        print(responseJson);
        bannerUrl1 = "http://www.aswaqrak.ae/pub/media/";
        bannerUrl2 = "http://www.aswaqrak.ae/pub/media/";

        var bannerString = responseJson['content'];

        var document = parse(bannerString);
        setState(() {
          bannerCount = document
              .getElementsByTagName('img')
              .length;
        });
        for (var i = 0; i < document
            .getElementsByTagName('img')
            .length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString = document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            bannetList.add(
                bannerUrl1 + urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
   setState(() {
     imageSliders = bannetList.map((item) => Container(
       child: Container(
         margin: EdgeInsets.all(5.0),
         child: ClipRRect(
             borderRadius: BorderRadius.all(Radius.circular(5.0)),
             child: Center(
                  child:
                  CachedNetworkImage(
                    fit: BoxFit.fill,
                    height: 230,

                    imageUrl: item,
                    placeholder: (context, url) => Center(
                      child: SpinKitPulse(
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image(
                      fit: BoxFit.contain,
                      height: 400,
                      image: AssetImage('assets/images/bg2.jpg', ),
                    ),
                  ),
         ),
         ),
       ),
     )).toList();
   });

  }

  Future loadCoupenBanner() async {
    var url ='https://aswaqrak.ae/rest/V1/cmsBlock/53';
    try {
      print(url);
      var response = await http.get(url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl1 = "http://www.aswaqrak.ae/pub/media/";
        bannerUrl2 = "http://www.aswaqrak.ae/pub/media/";
        var bannerString = responseJson['content'];

        var document = parse(bannerString);

        for (var i = 0; i < document
            .getElementsByTagName('img')
            .length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString = document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            offerBannerList.add(
                bannerUrl1 + urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    setState(() {
      imageSliders = bannetList.map((item) => Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Center(
              child:
              CachedNetworkImage(
                fit: BoxFit.fill,
                height: 230,

                imageUrl: item,
                placeholder: (context, url) => Center(
                  child: SpinKitPulse(
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
                errorWidget: (context, url, error) => Image(
                  fit: BoxFit.contain,
                  height: 400,
                  image: AssetImage('assets/images/bg2.jpg', ),
                ),
              ),
            ),
          ),
        ),
      )).toList();
    });

  }
  Future loadCategoryBanner() async {
    var url ='https://aswaqrak.ae/rest/V1/cmsBlock/50';
    try {
      print(url);
      var response = await http.get(url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        bannerUrl1 = "http://www.aswaqrak.ae/pub/media/";
        bannerUrl2 = "http://www.aswaqrak.ae/pub/media/";
        var bannerString = responseJson['content'];

        var document = parse(bannerString);

        for (var i = 0; i < document
            .getElementsByTagName('img')
            .length; i++) {
          final start = '\"';
          final end = '\"';
          String urlString = document.getElementsByTagName('img')[i].attributes['src'];
          print("responseJson");

          final startIndex = urlString.indexOf(start);
          final endIndex = urlString.indexOf(end, startIndex + start.length);
          setState(() {
            categoryBannerList.add(
                bannerUrl1 + urlString.substring(startIndex + start.length, endIndex));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    setState(() {
      imageSliders = bannetList.map((item) => Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Center(
              child:
              CachedNetworkImage(
                fit: BoxFit.fill,
                height: 230,

                imageUrl: item,
                placeholder: (context, url) => Center(
                  child: SpinKitPulse(
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
                errorWidget: (context, url, error) => Image(
                  fit: BoxFit.contain,
                  height: 400,
                  image: AssetImage('assets/images/bg2.jpg', ),
                ),
              ),
            ),
          ),
        ),
      )).toList();
    });

  }
  Future getProductList() async {
    ApiRepository.loadProduct().then((userDataFromServer) {
      if (userDataFromServer != null) {
        setState(() {
          productList = userDataFromServer;
          _progressController = false;
          productqty =
              new List<int>.generate(productList.items.length, (i) => 1 );
          productPrice =
          new List<double>.generate(productList.items.length, (i) => 0.0);

        });
//       callPrice();
      } else {
        print("Somithing went wrong...!");
      }
    });
  }
  Future getHealthcareProduct() async {

    ApiRepository.loadProductByCat(315).then((userDataFromServer) {
      print("heathcare went wrong...!");
      if (userDataFromServer != null) {
        setState(() {
          print("heathcare went wrong...!");
          popularList = userDataFromServer;
          popularqty =
          new List<int>.generate(popularList.items.length, (i) => 1 );
          popularPrice =
          new List<double>.generate(popularList.items.length, (i) => 0.0);

        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }
  callPrice(){
    for(int i = 0; i<productList.items.length; i++ ){
      if(productList.items[i].typeId == "configurable") {

        getProductPrice(productList.items[i].sku, i);
      }
    }
  }

  getProductPrice(String sku, int i) async {
    print("inside...");
    print('https://aswaqrak.ae/rest/V1/configurable-products/$sku/children');
    final response = await http.get(
      'https://aswaqrak.ae/rest/V1/configurable-products/$sku/children',
      headers: {
        "Content-Type": "application/json"
      },
    );
    final responseJson = json.decode(response.body);
    setState(() {
      var price  =  responseJson[0]['price'] + 0.0;

      productPrice.insert(i, price);

    });

  return  ;
  }

  Future getBestSellingList() async {
    ApiRepository.loadProductByCat(1516).then((userDataFromServer) {

      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          bestSellingList = userDataFromServer;
          bestSellingqty =
              new List<int>.generate(bestSellingList.items.length, (i) =>  1);
        });
      } else {
        print("Somithing went wrong...!");
      }
    });
  }


  Future getHotSellingList() async {
    ApiRepository.loadProductByCat(1517).then((userDataFromServer) {
      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          topSellingList = userDataFromServer;
          hotProductQty = new List<int>.generate(topSellingList.items.length, (i) => 1);
        });
      } else {
        print("Something went wrong...!");
      }
    });
  }


  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final loginStatus = prefs.getBool('isLoggedIn');
    if (loginStatus == true) {
      print("logged user home");
      await listenForUserKey();
      await addCartUserQuote();
      await getUserCartList();
      await getUserInfo();
      HomePageState.isLogin = true;
    } else {
      print("guest user");
      await listenForGuestKey();
      await getGuestCartList();
      HomePageState.isLogin = false;
    }
    return prefs.getBool('isLoggedIn');
  }

  Future<http.Response> listenForGuestKey() async {
    print("guest key");
    var url = 'https://aswaqrak.ae/rest/V1/guest-carts';
    var response =
        await http.post(url, headers: {"Content-Type": "application/json"});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('guestKey', response.body);
    String token = prefs.getString('guestKey');
    print("guest key");
    print("${token}");
    return response;
  }

  Future<http.Response> listenForAdminKey() async {
    var url = 'https://aswaqrak.ae/rest/V1/integration/admin/token';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
//      "username": "alaswaq1_api",
//      "password": "Nexa.2020",
      "username": "alaswaq_api",
      "password": "Nexa.2020",
    };
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    prefs.setString('adminKey', response.body);
    String token = prefs.getString('adminKey');
    print("admin key");
    print(token);
//    getPopularList(token);
//    getbestSelling(token);
    return response;
  }

  Future<http.Response> listenForUserKey() async {
    var url = 'https://aswaqrak.ae/rest/V1/integration/customer/token';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('email');
    String password = prefs.getString('password');
    print("listen for user key");
    print(username);
    print(password);
    Map data = {"username": username, "password": password};

//    Map data =  {
//      "username": "abc@abc.abc",
//      "password": "Qwerty1@"
//    };

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    prefs.setString('userKey', response.body);
    String token = prefs.getString('userKey');
    print("user key");
    print("${token}");
    return response;
  }

  Future addCartUserQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    final response = await http.post(
      'http://aswaqrak.ae/rest/V1/carts/mine',
      headers: {HttpHeaders.authorizationHeader: headerText},
    );
    final responseJson = json.decode(response.body);
    prefs.setString('userQuoteId', response.body);
    return response;
  }

  Future addCartGuest(String skuVAl, int qty) async {
    print("testttt");
    _key.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Colors.white,
          duration: new Duration(seconds: 2),
          content: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new  SpinKitPulse(
                color: Colors.red,
                size: 50.0,
              ),
              new Text("Adding to cart..",
                style:  TextStyle( fontFamily: 'montserrat',
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),)


            ],
          ),
        ));
    print(" this nis sku val in main");
    print(qty);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    var url = 'https://aswaqrak.ae/rest/V1/guest-carts/$token2/items';
    print(url);

    Map data = {
      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("guest cart added");
    print(response);
    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      getGuestCartList();
    });

    return response;
  }

  Future addCartUser(String skuVAl, int qty) async {
    print("dce");
    _key.currentState.showSnackBar(

        new SnackBar(
          backgroundColor: Colors.white,
          duration: new Duration(seconds: 2),
          content: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new  SpinKitPulse(
                color: Colors.red,
                size: 50.0,
              ),
              new Text("  Adding to cart..",
                style:  TextStyle( fontFamily: 'montserrat',
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),)
            ],
          ),
        )
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    Map data = {
      "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": qty}
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        'https://aswaqrak.ae/rest/V1/carts/mine/items',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body);
    print("cart logined user added");

    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      getUserCartList();
    });
    return response;
  }

  Future totalGuestCartUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http.get(
        'https://aswaqrak.ae/rest/V1/guest-carts/$token2/totals',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        });
    final responseJson = json.decode(response.body);
    print("cart total");
    print(responseJson);
      HomePage.cartListModel =  CartListModel.fromJson(responseJson);
  }

  Future totalUserCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    var response = await http
        .get('https://aswaqrak.ae/rest/V1/carts/mine/totals', headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: headerText
    });
    final responseJson = json.decode(response.body);
    print("cart total");
    print(responseJson);
//    MainHome.cartListModel =  cartListModel.fromJson(responseJson);
  }

//  Future getGuestCartList() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    print('http://alaswaq1.bgm.me/rest/V1/guest-carts/$token2/items');
//    final response = await http.get(
//      'http://alaswaq1.bgm.me/rest/V1/guest-carts/$token2/items',
//      headers: {
//        "Content-Type": "application/json",
//        HttpHeaders.authorizationHeader: headerText
//      },
//    );
//    final responseJson = json.decode(response.body);
//    var count = responseJson.length;
//    print("number of items in cart");
//    print(count);
//    setState(() {
//      HomePage.cartCount = responseJson.length;
//    });
//  }

  Future getUserCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
<<<<<<< HEAD
    final response = await http.get(
      'http://alaswaq1.bgm.me/rest/V1/carts/mine/items',
=======
    print('https://aswaqrak.ae/rest/V1/guest-carts/$token2/items');
    final response = await http.get(
      'https://aswaqrak.ae/rest/V1/guest-carts/$token2/items',
>>>>>>> november_1
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    var count = responseJson.length;
    print("cart count");
    print(count);
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
    totalUserCart();
  }

  Future getGuestCartList() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    final response = await http.get(
<<<<<<< HEAD
      'http://alaswaq1.bgm.me/rest/guest-carts/$token2/items',
      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText},
=======
      'https://aswaqrak.ae/rest/V1/carts/mine/items',
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
>>>>>>> november_1
    );
    final responseJson = json.decode(response.body);
    var count =  responseJson.length;
    print("cart count");
    print(count);
    setState(() {
      HomePage.cartCount =  responseJson.length;
    });
    totalGuestCartUser();
  }

  // ignore: missing_return
  Future<bool> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('firstname');
    });
  }

  void logoutUser() {
    setState(() async {
      print("inside logoutt");
      HomePageState.isLogin = false;
      HomePage.cartCount = 0;
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Dashboard()),
      );
    });

  }
}
Future<bool> isInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
}