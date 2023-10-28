

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/common/Theme.dart';

import 'Screens/Cart.dart';
import 'Screens/Catalog.dart';
import 'Screens/Login.dart';
import 'models/CatalogModel.dart';
import 'models/cartModel.dart';

void main() {
  runApp( MyApp());
}
GoRouter router(){
  return GoRouter(
    initialLocation: '/login', routes: [
      GoRoute(path: '/login',
      builder: (context,State)=>MyLogin(),
      ),
    GoRoute(path: '/Catalog',
      builder: (context,State)=>MyCatalog(),
    ),
    GoRoute(path: '/Cart',
      builder: (context,State)=>MyCart(),
    ),
  ]
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**
     * The benefit of using multiprovider is to
     * have a convience of proving multiple objects
     * */
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CatalogModel(),
        ),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart) {
              if (cart == null) throw ArgumentError.notNull('cart');
              cart.catalog = catalog;
              return cart;
            })
      ],
      child: MaterialApp.router(
        title: 'Shopping App',
        theme: AppTheme,
        routerConfig: router(),
      ),
    );
  }
}
