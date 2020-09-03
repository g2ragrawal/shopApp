import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jain_namkin/Screens/Order_screen.dart';
import 'package:jain_namkin/Screens/add_address.dart';
import 'package:jain_namkin/Screens/auth_screen.dart';
import 'package:jain_namkin/Screens/category_product_screen.dart';
import 'package:jain_namkin/Screens/home_page.dart';
import 'package:jain_namkin/Screens/product_detail_screen.dart';
import 'package:jain_namkin/model/home_model.dart';
import 'package:jain_namkin/provider/address_provider.dart';
import 'package:jain_namkin/provider/auth_provider.dart';
import 'package:jain_namkin/provider/cart_provider.dart';
import 'package:jain_namkin/provider/order_provider.dart';
import 'package:jain_namkin/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx)=>Auth(),),ChangeNotifierProvider(create: (ctx)=>Products()),ChangeNotifierProvider(create: (ctx)=>Cart()),ChangeNotifierProxyProvider<Auth,AddressProvider>(update: (ctx,auth,previousAddress)=>AddressProvider(auth.token,
        auth.userId,previousAddress==null?[]:previousAddress.items),),ChangeNotifierProvider(create: (ctx)=>HomeModel()),ChangeNotifierProxyProvider<Auth,OrderProvider>(update: (ctx,auth,previousAddress)=>OrderProvider(auth.token,
          auth.userId,previousAddress==null?[]:previousAddress.orders),)],
      child: Consumer<Auth>(
        builder:(ctx,auth,_)=> MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primaryColor: Colors.white,
//      ),
          home:auth.isAuth
              ? FutureBuilder(
            future: auth.autologin(),
            builder: (ctx, authResult) =>
            authResult.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : AuthScreen(),)
              : MyHomePage(),
          routes: {
            '/productItem': (context) => ProductDetail(),
            'categoryScreen': (context) => CategoryScreen(),
            '/addAddress':(context)=> AddAddressScreen(),
            '/orderScreen':(context) => OrderScreen(),
          },
        ),
      ),
    );
  }
}









