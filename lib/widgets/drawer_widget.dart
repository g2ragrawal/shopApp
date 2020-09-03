import 'package:flutter/material.dart';
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: Text('Cart'),
            leading: Icon(Icons.shopping_cart),
          ),
          ListTile(
            title: Text('Offers'),
            leading: Icon(Icons.local_offer),
          ),
          ListTile(
            title: Text('profile'),
            leading: Icon(Icons.perm_identity),
          ),
        ],
      ),
    );
  }
}