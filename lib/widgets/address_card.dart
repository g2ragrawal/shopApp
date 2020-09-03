import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final addressItem;

  AddressCard({this.addressItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey[100]),
      margin: EdgeInsets.only(right: 8, left: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(addressItem.name),
          Text(
            addressItem.addressLine1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
