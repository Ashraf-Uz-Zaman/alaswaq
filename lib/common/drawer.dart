import 'package:Alaswaq/account/profile/my_account.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:Alaswaq/home/dashboard.dart';
import 'package:Alaswaq/home/home_page_new.dart';
import 'package:Alaswaq/account/login/login_page.dart';
<<<<<<< HEAD
import 'package:Alaswaq/others/screens/about_alaswaq.dart';
import 'package:Alaswaq/others/screens/delivery_information.dart';
import 'package:Alaswaq/others/screens/privacy_policy.dart';
import 'package:Alaswaq/others/screens/terms_conditions.dart';
=======
import 'package:Alaswaq/orders/orders.dart';
import 'package:Alaswaq/others/Notifications.dart';
import 'package:Alaswaq/others/about_alaswaq.dart';
import 'package:Alaswaq/others/contact_us.dart';
import 'package:Alaswaq/others/delivery_imnformation.dart';
import 'package:Alaswaq/others/faq.dart';
import 'package:Alaswaq/others/notification2.dart';
import 'package:Alaswaq/others/privacy_policy.dart';
import 'package:Alaswaq/others/return_policy.dart';
import 'package:Alaswaq/others/store_locations.dart';
import 'package:Alaswaq/others/terms_conditions.dart';
import 'package:Alaswaq/product/search/show_search_product_page.dart';
import 'package:Alaswaq/utils/style/color.dart';
>>>>>>> november_1
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => new AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
//  String memberName="",memberUniqeId="",gender="";
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//  Future getdata() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    memberName = prefs.getString("name");
//    memberUniqeId = prefs.getString("memberUniqeId");
//    gender = prefs.getString("gender");
//
//    if (memberName == null) {
//      memberName = "";
//    }
//    if (memberUniqeId == null) {
//      memberUniqeId = "";
//    }a
//    if (gender == null) {
//      gender = "";
//    }
//  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            width: screenSize.width,
            height: 200,
            decoration: new BoxDecoration(
              color: Color(0xFF2F3590),
            ),
            child: new Column(
              children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Container(
//                              width: screenSize.width,
//                              child: Image.asset(
//                                'images/drawer_header_title.png',
//                                fit: BoxFit.contain,
//                                width: 150,
//                                height: 100,
//                              )
//                          ),
//                        ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20, bottom: 10),
                  child: Container(
                    width: screenSize.width,
//                            child: new Text(
//                              'Mamun',
//                              softWrap: true,
//                              overflow: TextOverflow.clip,
//                              textAlign: TextAlign.left,
//                              style: TextStyle( fontFamily: 'montserrat',
//                                  fontSize: 30,color: Colors.white
//                              ),
//                            ),
                    child: GestureDetector(
                      onTap: () {
//                        Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => (HomePageState.isLogin ) ? MyAccount() : LogInPage(toPageId: 2,),));
                      },
                      child: HomePageState.isLogin
                          ? Text(
                              HomePageState.userName,
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'montserrat', fontSize: 30, color: Colors.white),
                            )
                          : Text(
                              'Guest User',
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'montserrat', fontSize: 30, color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: new Row(
                    children: <Widget>[
                      Container(
//                          color: Colors.white,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /*    new Image.asset(
                                        'images/king.png'),*/
//                                    Image.asset('images/king_header.png'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => MyAccount("From Home")));
                              },
                              child: new Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: new Text(
                                  "View Profile",
                                  style: TextStyle( fontFamily: 'montserrat', color: Colors.white),
                                ),
                              ),
                            ),
                            // new Image.asset('images/crousal_right_icon.png'),
                          ],
                        ),
                      ),
//                              SizedBox(width: 5,),
//                              Container(
//                                padding: EdgeInsets.all(5),
//                                height: 20,
//                                decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius: BorderRadius.circular(4),
//                                ),
//                                child: Row(
//                                  children: [
////                                    gender=="Female" ?
////                                    new Image.asset('images/female_gender.jpg') :
//                                    new Image.asset('images/male_gender_icon.png')
//                                  ],
//                                ),
//                              ),
//                              SizedBox(width: 5,),
//                              Image.asset('images/flag1.png',fit: BoxFit.contain,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Column(
            children: <Widget>[
//              GestureDetector(
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Dashboard()),
//                  );
//                },
//                child:
//                Padding(
//                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ListTile(
//                      title: Text(
//                        'Home',
//                        style: new TextStyle( fontFamily: 'montserrat',
//                          fontSize: 14.0,
////                                  color: UniversalVariables.blackColor
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.of(context).pop();
////                        Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => HomePage()),
////                        );
//                      }),
//                ),
//              ),
//              Divider(
//                height: 2,
//                thickness: 1,
////                        color: UniversalVariables.greyColorWithOpacity,
//                indent: 25,
//                endIndent: 25,
//              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'Orders',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
                    onTap: () {
                      if (HomePageState.isLogin ) {
                        print("in logged... draw..");
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => OrdersList("from Home")));

                      } else {
                        print("in guest.....");

                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => LogInPage(2)));

                      }
                    }),
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'About Alaswaq',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
<<<<<<< HEAD
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutAlaswaq()));
                  },

                    ),
=======
                    onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>
                            AboutAlaswaq()),
                            );

                    }),
>>>>>>> november_1
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'Featured Products',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowSearchProductPage(
                                    categoryId: 80,
                                    name: "Featured")),
                      );
                    }),
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'What\'s on Sale',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowSearchProductPage(
                                    categoryId: 79,
                                    name: "On Sale")),
                      );
                    }),
              ),

//
//              Divider(
//                height: 2,
//                thickness: 1,
////                        color: UniversalVariables.greyColorWithOpacity,
//                indent: 25,
//                endIndent: 25,
//              ),
//
//              Divider(
//                height: 2,
//                thickness: 1,
////                        color: UniversalVariables.greyColorWithOpacity,
//                indent: 25,
//                endIndent: 25,
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 10.0),
//                child: ListTile(
//                    title: Text(
//                      'Terms and Conditions',
//                      style: new TextStyle( fontFamily: 'montserrat',
//                        fontSize: 14.0,
////                                  color: UniversalVariables.blackColor
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.of(context).pop();
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) =>
//                                TermsAndConditions()),
//                      );
//                    }),
//              ),
//              Divider(
//                height: 2,
//                thickness: 1,
////                        color: UniversalVariables.greyColorWithOpacity,
//                indent: 25,
//                endIndent: 25,
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 10.0),
//                child: ListTile(
//                    title: Text(
//                      'Shipping & Returns',
//                      style: new TextStyle( fontFamily: 'montserrat',
//                        fontSize: 14.0,
////                                  color: UniversalVariables.blackColor
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) =>
//                                ReturnPolicy()),
//                      );
//                    }),
//              ),
//              Divider(
//                height: 2,
//                thickness: 1,
////                        color: UniversalVariables.greyColorWithOpacity,
//                indent: 25,
//                endIndent: 25,
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 10.0),
//                child: ListTile(
//                    title: Text(
//                      'Track Your Order',
//                      style: new TextStyle( fontFamily: 'montserrat',
//                        fontSize: 14.0,
////                                  color: UniversalVariables.blackColor
//                      ),
//                    ),
//                    onTap: () {
////                              _postData();
//                      /*  initConnectivity();
//                              setState(() {
//                                if ((_connectionStatus ==
//                                    "ConnectivityResult.mobile" ||
//                                    _connectionStatus ==
//                                        "ConnectivityResult.wifi")) {
//                                  _postData();
//
//                                }
//                                else{
//                                  _showDialog("Connection error !", "No internet connection");
//                                }
//                              });*/
//                    }),
//              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              GestureDetector(
                onTap: () {

//                  Navigator.of(context).push(
//                      MaterialPageRoute(builder: (context) => (HomePageState.isLogin ) ? MyAccount() : LogInPage(toPageId: 2,),));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListTile(
                    title: Text(
                      'My Account',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
<<<<<<< HEAD
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeliveryInformation()));
                  },

                    ),
=======
                    onTap: () {
                      {
                        if ( HomePageState.isLogin ) {
                          print("in logged... draw..");
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MyAccount("From Home")));

                        } else {
                          print("in guest.....");

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                              LogInPage(2)));
                        }


                      }
                    },
                  ),
                ),
>>>>>>> november_1
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'Notification',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
<<<<<<< HEAD
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
                  },

                    ),
=======
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Notifications2()));

                    }),
>>>>>>> november_1
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'Contact Us',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
<<<<<<< HEAD
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TermsAndConditions()));
                  },

                    ),
=======
                    onTap: () {

                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ContactUs()));
                    }),
>>>>>>> november_1
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    title: Text(
                      'Store Locations',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),
<<<<<<< HEAD
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeliveryInformation()));
                  },),
=======
                    onTap: () {

                   Navigator.push(
                              context, MaterialPageRoute(builder: (context) => StoreLocations()));
                    }),
>>>>>>> november_1
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  title: HomePageState.isLogin
                      ? Text(
                          'Logout',
                          textAlign: TextAlign.left,
                      style: new TextStyle( fontFamily: 'montserrat',),
                        )
                      : Text('Login', textAlign: TextAlign.left,
                    style: new TextStyle( fontFamily: 'montserrat',),
                  ),
                  onTap: () async {
                    if (HomePageState.isLogin) {
//                        logoutUser();
//                      SharedPreferences prefrences =
//                          await SharedPreferences.getInstance();
//
//                      await prefrences.clear();
                   _showDialog();
                      print("inside logoutt");
                      setState(() {
                        HomePageState.isLogin = false;
                        HomePage.cartCount = 0;
                      });


                      print("inside logoutt");

                    } else {
                      print("in guest..... log");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInPage(
                                     1,
                                  )));
                    }
                  },
                ),
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),
              SizedBox(
                height: 30,
              ),


              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                child: ListTile(
                    title: Text(
                      'Social Media',
                      style: new TextStyle( fontFamily: 'montserrat',
                        fontSize: 14.0,
//                                  color: UniversalVariables.blackColor
                      ),
                    ),

                    trailing:  Row(
                    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    IconButton(
    icon: Image.asset('assets/images/icons/facebook.png', height: 20,color: HexColor("302c98")),

    onPressed:  () async {
    const url = 'https://www.facebook.com/rak.nationalmarkets/';

    if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
    } else {
    throw 'Could not launch $url';
    }
    }, // null disables the button
    ),

    SizedBox(
    width: 10,
    ),
    IconButton(
    icon: Image.asset('assets/images/icons/instagram.png', height: 20,color: HexColor("302c98")),

    onPressed:  () async {
    const url = 'https://www.instagram.com/rak.nationalmarkets/';

    if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
    } else {
    throw 'Could not launch $url';
    }
    }, // null disables the button
    ),

    SizedBox(
    width: 10,
    ),

    ],
    ),

                    onTap: () {
//
                    }),
              ),
              Divider(
                height: 2,
                thickness: 1,
//                        color: UniversalVariables.greyColorWithOpacity,
                indent: 25,
                endIndent: 25,
              ),


              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child:  SizedBox(
                  height: 130,
                  child:  Column (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 2 - 40 ,
                            child: FlatButton(

                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DeliveryInformation()),
                                );
                              },
                              child: Text('Delivery Information', style: TextStyle(
                                  color:  Colors.black54, fontSize: 11,fontFamily: 'montserrat'
                              )
                              ),
//
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 2 - 80 ,
                            child:  FlatButton(

                              onPressed: () async {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyPolicy()),
                                );
                              },
                              child: Text('Privacy Policy', style: TextStyle(
                                  color:  Colors.black54, fontSize: 11,fontFamily: 'montserrat'
                              )
                              ),
                            ),
                          ),



                        ],

                      ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 2 - 20 ,
                            child: FlatButton(

                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TermsAndConditions()),
                                );
                              },
                              child: Text('Terms and Conditions', style: TextStyle(
                                  color:  Colors.black54, fontSize: 11,fontFamily: 'montserrat'
                              )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 3  - 40 ,
                            child:  FlatButton(

                              onPressed: () async {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReturnPolicy()),
                                );
                              },
                              child: Text('Shipping and Returs', style: TextStyle(
                                  color:  Colors.black54, fontSize: 11,fontFamily: 'montserrat'

                              )
                              ),
                            ),
                          ),


                        ],

                      ),
                      Center(
                        child: SizedBox(
                        height: 30,
                        child: FlatButton(

                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FAQ()),
                            );
                          },
                          child: Text('FAQ', style: TextStyle(
                              color:  Colors.black54, fontSize: 11,fontFamily: 'montserrat'
                          )
                          ),
                        ),
                      ),
    ),


                    ],
                  ),
                ),




              ),

            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

/*    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() {
            _connectionStatus = result.toString();
          });
        });
    print("Initstate : $_connectionStatus");*/
  }

  @override
  void dispose() {
    //_connectionSubscription.cancel();
    super.dispose();
  }

/*  Future<Null> initConnectivity() async {
    String connectionStatus;
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = "Internet connectivity failed";
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _connectionStatus = connectionStatus;
    });
    print("InitConnectivity : $_connectionStatus");
    if ((_connectionStatus == "ConnectivityResult.mobile" ||
        _connectionStatus == "ConnectivityResult.wifi")) {
    } else {
      _showDialog("Connection Error !", "Please enable internet connection");
    }
  }*/

//  _postData() async {
//    //showDialog(context: context, child: progress);
//    http.post(LOGOUT_URL+"52D00E44-FD7F-4CCA-B287-802B2A067E96", body: {}).then((response) async{
//      print("Response body: ${response.body}");
//      var statusResult = json.decode(response.body);
//      bool message = statusResult['isSuccess'];
//      if(message == true)
//      {
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        prefs.remove('memberId');
//        prefs.remove('memberUniqeId');
//        prefs.remove('name');
//        prefs.remove('phoneNumber');
//        prefs.remove('userName');
//        prefs.remove('email');
//        prefs.remove('picture');
//        prefs.remove('gender');
//        prefs.clear();
//        //Navigator.pop(context);
//        Navigator.pop(context);
//        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new LoginPageLatest()));
//        //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPageLatest()));
//      }
//      else{
//        _showDialog("Failed", "Something went wrong");
//      }
//
//    });
//  }
//  var progress = new ProgressHUD(
//    backgroundColor: Colors.black54,
//    color: Colors.white,
//    containerColor: Colors.transparent,
//    borderRadius: 10.0,
//    text: "Loading....",
//  );
//
//  void _showDialog(String title, String msg) {
//    final screenSize = MediaQuery.of(context).size;
//    showDialog(
//      context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          //title: new Text(title),
//          content: new Text(msg),
//          actions: <Widget>[
//            SizedBox(width: screenSize.width / 50),
//            new Container(
//              width: screenSize.width / 2.80,
//              child: new RaisedButton(
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//                child: new Text("Back"),
//                textColor: Colors.white,
//                //color: Colors.purple,
//              ),
//            ),
//          ],
//        );
//      },
//    );
//  }
  void logoutUser()  {

    setState(() async {
      print("inside logout");

      HomePageState.isLogin = false;
      HomePage.cartCount = 0;
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => MyHomePage()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    });

  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(

          content: new Text("Do you want to logout"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                logoutUser();
              },
            ),
          ],
        );
      },
    );
  }

}
