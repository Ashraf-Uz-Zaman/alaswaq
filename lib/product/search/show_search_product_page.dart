import 'dart:convert';
import 'dart:io';
import 'package:Alaswaq/Model/category_model.dart';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Network/api_repository.dart';
import 'package:Alaswaq/common/drawer.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input.dart';
import 'package:Alaswaq/packages/text_box/lib/product_box_input4.dart';
import 'package:Alaswaq/payment/shopping_cart.dart';
import 'package:Alaswaq/product/filter/filters.dart';
import 'package:Alaswaq/product/search/search_from_home.dart';
import 'package:Alaswaq/product/single_product/configurable_single_product.dart';
import 'package:Alaswaq/product/single_product/single_product.dart';
import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShowSearchProductPage extends StatefulWidget {
  int categoryIndex;
  ProductListModel productList;
  String sku;
  int categoryId;
  String name;

  ShowSearchProductPage({this.productList, this.sku,this.categoryId,this.name});

  @override
  ShowSearchProductPageState createState() => ShowSearchProductPageState();
}

class ShowSearchProductPageState extends State<ShowSearchProductPage> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  static CategoryModel categoryList;
  static var productType = [];
//  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController editingController = TextEditingController();
   var productPrice = [];
  int _selectedIndex = 0;
  var pressedIndex = 0;
  var productqty = [];
  List<int> level1CatId = [];
  List<String> catName = [];

  bool _progressController = true;
  bool _progressPriceController = true;
  var isLogin = false;
  static var allOptionPrice = [];
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onPressed(int index) {
    setState(() => pressedIndex = index);
  }

   ProductListModel productList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      isLoggedIn();
      if(widget.name != "from filter"){
        _progressController = true;
        await  getProductList(
            widget.categoryId);
      }




    });
    // Setting the initial value for the field.
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // hides leading widget
//        flexibleSpace: Container(),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black87,
            size: 30,
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width ,
          height: 40,
          child:


          TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchFromHome( name: editingController.text)),
              );
            },
            controller: editingController,

            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0,top: 0.0,bottom: 20.0),
//                              labelText: "Search your products",
//                              labelStyle: TextStyle(
//                                  color:  Colors.black
//                              ),
              suffixIcon: IconButton(
                onPressed: () {
                  print("search");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchFromHome( name:editingController.text)),
                  );
                },
                icon: Icon(Icons.search, color: HexColor("A3A3A3"),size: 25,),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: HexColor("A3A3A3"), width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: HexColor("A3A3A3"), width: 0.5),

              ),
              hintText: "Search your products",
            ),
            style: TextStyle(
                fontSize: 13,  fontFamily: 'lato'  // This is not so important
            ),
//
          ),
        ),
//        Text(
//          'Search Products',
//          style: TextStyle( fontFamily: 'montserrat',
//              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//        ),
        actions: [

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingCart()));
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
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/icons/cart.png',
                      height: 35,
                    ),
                  ),
                  HomePage.cartCount == 0
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
          ),
        ],
      ),
      body:    _progressController
          ?  Center(
        child: SpinKitPulse(
          color: Colors.red,
          size: 50.0,
        ),
      )
          :
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(productList.items.length.toString()+' Results Found',style: TextStyle( fontFamily: 'montserrat', fontSize: 12),),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _progressController = true;
                          });

                                  await getCategoryList();


                        },
                        child: Image.asset(
                          'assets/images/icons/icon.png',
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          _settingModalBottomSheet(context);
                        },
                        child: Image.asset(
                          'assets/images/icons/icon2.png',
                          height: 20,
                        ),
                      ),


                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
                    height: MediaQuery.of(context).size.height*.82,
//              height: 242,
//                      width: 100,


              child: GridView.builder(
                padding: const EdgeInsets.all(1),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: productList.items.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
//                  childAspectRatio: 16 / 20,
                  childAspectRatio: 18/34,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,

                ),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
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
                        child: _progressPriceController
                            ?  Center(
                          child: SpinKitPulse(
                            color: Colors.red,
                            size: 50.0,
                          ),
                        )
                            :
                        Card(
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
//                                    width: 100,
                                    height: 100,
                                    child: CachedNetworkImage(
//                                          width: 200,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                      imageUrl:  productList
                                          .items[index]
                                          .mediaGalleryEntries.length > 0 ?
                                      "https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475" +
                                          productList
                                              .items[index]
                                              .mediaGalleryEntries[0]
                                              .file : "https://aswaqrak.ae/pub/media/logo/websites/1/logo.png",
                                      placeholder: (context, url) => Center(
                                          child:
                                           SpinKitPulse(
                                              color: Colors.red,
                                              size: 50.0,
                                            ),),
                                      errorWidget:
                                          (context, url, error) =>
                                      new Icon(Icons.error),
                                    ),
                                  ),
//
                                ],
                              ),
                              SizedBox(height: 2,),
                              Row(
                              children: [
                                productList.items[index].typeId == "configurable"  ?    Text(
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
//                              Flexible(
//                                child: Container(
//                                  width: 100,
//                                  padding: EdgeInsets.only(
//                                      left: 5, right: 5,top: 5,bottom: 5),
//                                  child: Text(
//                                    productList.items[index].name
//                                        .toString().substring(0,9),
//                                    textAlign: TextAlign.center,
//                                    overflow: TextOverflow.clip,
//                                  ),
//                                ),
//                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3 - 20,
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
                                child:  Container(
                                  padding: EdgeInsets.only(left: 5),
                                  height: 25.0,
                                  width: MediaQuery.of(context).size.width *
                                      .3,
                                  // fixed width and height
                                  child: NumberInputWithIncrementDecrement4(
                                    controller: TextEditingController(),
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
                                    numberFieldDecoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    decIconColor: HexColor('e25814'),
                                    widgetContainerDecoration:
                                    BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        border: Border.all(
                                          color: Colors.black26,
                                          width: 1,
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
                                    incIcon: Icons.add,
                                    decIcon: Icons.remove,
                                  ),
                                ),),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 27,
                                width: MediaQuery.of(context).size.width *
                                    .27,
                                decoration: BoxDecoration(
//                                            color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border.all(
                                      width: 1, color: HexColor('302c98')),
                                ),
                                child: FlatButton(
                                    onPressed: () async {
                                      if (!HomePageState.isLogin) {

                                        if(productList.items[index].typeId == "configurable") {
                                          Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => Products(productList, index,
                                                            productList.items[index].sku, productPrice[index], "configurable")),

                                                      );
                                        } else {
                                          await addCartGuest(
                                              productList.items[index].sku,
                                              productqty[index]);
                                        }


                                      } else {

                                        if(productList.items[index].typeId == "configurable") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (
                                              context) =>
                                              Products(
                                                  productList,
                                                  index,
                                                  productList
                                                      .items[index]
                                                      .sku,
                                                  productPrice[index],
                                                  "configurable")));


                                        }else {
                                          await addCartUser(
                                              productList.items[index].sku,
                                              productqty[index]);;
                                        }
//
                                      }
//
                                    },
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle( fontFamily: 'montserrat',
                                          color: HexColor('302c98'),
//                                                fontWeight: FontWeight.bold,
                                          fontSize: 8),
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
          ],
        ),
      ),
    );
  }

  bool isloggedIn = false;

  Future getProductList(int catId) async {
    ApiRepository.loadhotSellingProduct(catId).then((userDataFromServer) async {
      if (userDataFromServer != null) {
        setState(() {
          productList = userDataFromServer;
          productqty = new List<int>.generate(productList.items.length, (i) => 1);
          productPrice =
          new List<double>.generate(productList.items.length, (i) => 0.0);
          _progressController = false;
          callPrice();
        });

      } else {
        print("Somithing went wrong..s.!");
      }
    }
    );
  }
  Future getSortbyPosition() async {
    setState(() {
      _progressController = true;
    });
    ApiRepository.sortOnPostion(widget.categoryId).then((userDataFromServer) async {
      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          productList = userDataFromServer;
          productqty = new List<int>.generate(productList.items.length, (i) => 1);
          productPrice =
          new List<double>.generate(productList.items.length, (i) => 0.0);
          _progressController = false;
          callPrice();
        });

      } else {
        print("Somithing went wrong..s.!");
      }
    }
    );
  }
  Future getSortbyName() async {
    setState(() {
      _progressController = true;
    });
    ApiRepository.sortOnName(widget.categoryId).then((userDataFromServer) async {
      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          productList = userDataFromServer;
          productqty = new List<int>.generate(productList.items.length, (i) => 1);
          productPrice =
          new List<double>.generate(productList.items.length, (i) => 0.0);
          _progressController = false;
          callPrice();
        });

      } else {
        print("Somithing went wrong..s.!");
      }
    }
    );
  }
  Future getSortbyPrice() async {
    setState(() {
      _progressController = true;
    });
    ApiRepository.sortOnPrice(widget.categoryId).then((userDataFromServer) async {
      if (userDataFromServer != null) {
        setState(() {
          _progressController = false;
          productList = userDataFromServer;
          productqty = new List<int>.generate(productList.items.length, (i) => 1);
          productPrice =
          new List<double>.generate(productList.items.length, (i) => 0.0);
          _progressController = false;
          callPrice();
        });

      } else {
        print("Somithing went wrong..s.!");
      }
    }
    );
  }

  callPrice() async {
    setState(() {
      _progressPriceController = false;
    });

    for(int i = 0; i<productList.items.length; i++ ){
      if(productList.items[i].typeId == "configurable") {
        setState(() {
          _progressPriceController = true;
        });

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
      _progressPriceController = false;
      productPrice.insert(i, price);

    });

    return  ;
  }


  Future getCategoryList() async {
    ApiRepository.loadCategoryList().then((userDataFromServer) async {
      if (userDataFromServer != null) {
        catName = [];
        setState(() {
          _progressController = false;
        });

        setState(() {
          categoryList = userDataFromServer;
          print(widget.name );
          setState(() {
            catName = [];
            level1CatId = [];
          });
//          if(widget.name == "Fruits & Vegetables") {
              for (var i = 0; i < categoryList.childrenData.length; i++) {
                for(int j=0; j< categoryList.childrenData[i].childrenData.length; j++) {

                  for(int k=0; k< categoryList.childrenData[i].childrenData[j].childrenData.length; k++){
                    setState(() {
                      if(categoryList.childrenData[i].childrenData[j].childrenData[k].parentId == widget.categoryId) {
                        print("wwwwwwwww");
                        print(categoryList.childrenData[i].childrenData[j].childrenData[k].id);
                        catName.add(categoryList.childrenData[i].childrenData[j].childrenData[k].name)  ;
                        level1CatId.add(categoryList.childrenData[i].childrenData[j].childrenData[k].id);

                      }

                    });
                  }
                }
              }
//            }
//          else {
//            setState(() {
//              catName = [];
//              level1CatId = [];
//            });
//              for (var i = 0; i < categoryList.childrenData.length; i++) {
//                for(int j=0; j< categoryList.childrenData[i].childrenData.length; j++) {
//
//                    setState(() {
//                      if(categoryList.childrenData[i].childrenData[j].parentId == widget.categoryId) {
//                        print("categoryList.childrenData[i].childrenData[j].id");
//                        catName.add(categoryList.childrenData[i].childrenData[j].name)  ;
//                        level1CatId.add(categoryList.childrenData[i].childrenData[j].id);
//
//                      }
//
//                    });
//
//                }
//              }
//
//            }
          print(level1CatId.length);
          print(level1CatId[1]);
          print(level1CatId[2]);
          _key.currentState
              .showBottomSheet((context) => Filters("From ShowSearchProduct", widget.categoryId.toString(), catName,level1CatId));
        });

      } else {
        print("Somithing went wrong...!");
      }
    });
  }


  Future addCartGuest(String skuVAl, int qty) async {
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
    print(skuVAl);
    print(qty);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    var url = 'https://aswaqrak.ae/rest/V1/guest-carts/$token2/items';
    print(url);

    Map data = { "cartItem": { "quote_id": token2, "sku": skuVAl, "qty": qty}};
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("guest cart added search");
    print(response);
    final responseJson = json.decode(response.body);
    print(responseJson);

      getGuestCartList();

    return response;
  }
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return  Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  color: HexColor("302c98"),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                        child: Text('Sort By',
                            style: TextStyle( fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
            Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(

                    title: new Text('Position', style: TextStyle( fontFamily: 'montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 14,),),
                    onTap: () => {
                      getSortbyPosition(),
                      Navigator.pop(context),
                    }
                ),
                new ListTile(
                  title: new Text('Product Name', style: TextStyle( fontFamily: 'montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,),),
                  onTap: () => {
                    getSortbyName(),
                    Navigator.pop(context),

                  },
                ),
                new ListTile(
                    title: new Text('Price', style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,),),
                    onTap: () => {
                      getSortbyPrice(),
                      Navigator.pop(context),
                    }
                ),

              ],
            ),
            ),
            ],
          ),
          );

//
        }
    );
  }

  Future addCartUser(String skuVAl, int qty) async {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String quoteId = prefs.getString('userQuoteId');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;

    Map data = { "cartItem": { "quote_id": quoteId, "sku": skuVAl, "qty": qty}};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        'https://aswaqrak.ae/rest/V1/carts/mine/items',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: headerText
        },
        body: body
    );
    print("cart logined user added");

    final responseJson = json.decode(response.body);
    print(responseJson);
    setState(() {
      getUserCartList();
    });
    return response;
  }

  Future getUserCartList() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    final response = await http.get(
      'https://aswaqrak.ae/rest/V1/carts/mine/items',
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    var count = responseJson.length;
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
  }

  Future getGuestCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('guestKey');
    String token1 = token.replaceFirst(RegExp('"'), '');
    String token2 = token1.replaceFirst(RegExp('"'), '');
    String headerText = "Bearer " + token2;
    print('https://aswaqrak.ae/rest/V1/guest-carts/$token2/items');
    final response = await http.get(
      'https://aswaqrak.ae/rest/V1/guest-carts/$token2/items',
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: headerText
      },
    );
    final responseJson = json.decode(response.body);
    var count = responseJson.length;
    print("number of items in cart");
    print(count);
    setState(() {
      HomePage.cartCount = responseJson.length;
    });
  }
  Future<bool> isLoggedIn() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(prefs.getBool('isLoggedIn').toString());
    final  loginStatus =   prefs.getBool('isLoggedIn');
    if(loginStatus == true) {
      print("for  listen user key  user");
//      await listenForUserKey();
//      await addCartUserQuote();
//      await getUserCartList();
//      await getUserInfo();
      isLogin = true;
      HomePageState.isLogin = true;
    } else {
      print("for  listen guest user");
//      await  listenForGuestKey();
//      await getGuestCartList();
      HomePageState.isLogin = false;
    }
    return prefs.getBool('isLoggedIn');
  }

//  Future<bool> isLoggedIn() async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    debugPrint(prefs.getBool('isLoggedIn').toString());
//    final loginStatus = prefs.getBool('isLoggedIn');
//    print("logged staus");
//    print(loginStatus);
//    if (loginStatus == true) {
//      print("logged user");
//      setState(() {
//        isloggedIn = true;
//      });
//
//      await getUserCartList();
//    } else {
//      setState(() {
//        isloggedIn = false;
//      });
//
//      print("guest user");
//      await getGuestCartList();
//    }
//    return prefs.getBool('isLoggedIn');
////    await getUserCartList();
//  }
//
//  Future addCartGuest(String skuVAl, int qty) async {
//    _key.currentState.showSnackBar(new SnackBar(
//      duration: new Duration(seconds: 2),
//      content: new Row(
//        children: <Widget>[
//          new  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),,
//          new Text("Adding to cart..")
//        ],
//      ),
//    ));
//    print(" this nis sku val in main");
//    print(qty);
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    var url = 'https://aswaqrak.ae/rest/V1/guest-carts/$token2/items';
//    print(url);
//
//    Map data = {
//      "cartItem": {"quote_id": token2, "sku": skuVAl, "qty": qty}
//    };
//    //encode Map to JSON
//    var body = json.encode(data);
//    var response = await http.post(url,
//        headers: {"Content-Type": "application/json"}, body: body);
//    print("guest cart added");
//    print(response);
//    final responseJson = json.decode(response.body);
//    print(responseJson);
//    setState(() {
//      getGuestCartList();
//    });
//
//    return response;
//  }
//
//  Future addCartUser(String skuVAl, int qty) async {
//    _key.currentState.showSnackBar(new SnackBar(
//      duration: new Duration(seconds: 2),
//      content: new Row(
//        children: <Widget>[
//          new  SpinKitPulse(
//                                              color: Colors.red,
//                                              size: 50.0,
//                                            ),,
//          new Text("Adding to cart..")
//        ],
//      ),
//    ));
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('userKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//
//    Map data = {
//      "cartItem": {"quote_id": quoteId, "sku": skuVAl, "qty": qty}
//    };
//    //encode Map to JSON
//    var body = json.encode(data);
//
//    var response = await http.post(
//        'https://aswaqrak.ae/rest/V1/carts/mine/items',
//        headers: {
//          "Content-Type": "application/json",
//          HttpHeaders.authorizationHeader: headerText
//        },
//        body: body);
//    print("cart logined user added");
//
//    final responseJson = json.decode(response.body);
//    print(responseJson);
//    setState(() {
//      getUserCartList();
//    });
//    return response;
//  }
//
//  Future getGuestCartList() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    print('https://aswaqrak.ae/rest/V1/guest-carts/$token2/items');
//    final response = await http.get(
//      'https://aswaqrak.ae/rest/V1/guest-carts/$token2/items',
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
//
//  Future getUserCartList() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('userKey');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    final response = await http.get(
//      'https://aswaqrak.ae/rest/V1/carts/mine/items',
//      headers: {
//        "Content-Type": "application/json",
//        HttpHeaders.authorizationHeader: headerText
//      },
//    );
//    final responseJson = json.decode(response.body);
//    var count = responseJson.length;
//    print("cart count");
//    print(count);
//    setState(() {
//      HomePage.cartCount = responseJson.length;
//    });
////    totalUserCart();
//  }
//
//  Future totalGuestCartUser() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    var response = await http.get(
//        'https://aswaqrak.ae/rest/V1/guest-carts/$token2/totals',
//        headers: {
//          "Content-Type": "application/json",
//          HttpHeaders.authorizationHeader: headerText
//        });
//    final responseJson = json.decode(response.body);
//
//    print(responseJson);
////      HomePage.cartListModel =  cartListModel.fromJson(responseJson);
//  }
//
//  Future totalUserCart() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('guestKey');
//    String quoteId = prefs.getString('userQuoteId');
//    String token1 = token.replaceFirst(RegExp('"'), '');
//    String token2 = token1.replaceFirst(RegExp('"'), '');
//    String headerText = "Bearer " + token2;
//    var response = await http
//        .get('https://aswaqrak.ae/rest/V1/carts/mine/totals', headers: {
//      "Content-Type": "application/json",
//      HttpHeaders.authorizationHeader: headerText
//    });
//    final responseJson = json.decode(response.body);
//    print("cart total");
//    print(responseJson);
////    HomePage.cartListModel =  cartListModel.fromJson(responseJson);
//  }



}
