import 'dart:convert';

import 'package:jain_namkin/model/address_item.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier{
  List<AddressItem> _items=[];
  final String authToken;
  final String userId;
  AddressProvider(this.authToken,this.userId,this._items);

  List<AddressItem> get items{
    return [..._items];
  }

  Future<void> fetchAndSetAddress() async {
    var url = 'https://project_name.firebaseio.com/users/$userId/addresses.json';
    try {
      final response = await http.get(url);
      print(response.body);
      final fetchedData = json.decode(response.body) as Map<String, dynamic>;
      if(fetchedData==null){return;}
      List<AddressItem> loadedAddress = [];
      fetchedData.forEach((addressId, addressData) {
        loadedAddress.add(AddressItem(
          addressLine1: addressData['addressLine1'],
          addressLine2: addressData['addressLine2'],
          city: addressData['city'],
          name: addressData['name'],
          pincode: addressData['pincode'],
        ));
      });
      print(response.body);
      print(loadedAddress);
      _items = loadedAddress;
    } catch (error) {
      print(error);
    }
  }

  Future<void> addAddress(AddressItem address) async {
    final timeStamp = DateTime.now();
    var url = 'https://project_name.firebaseio.com/users/$userId/addresses.json';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'addressLine1':address.addressLine1,
          'addressLine2':address.addressLine2,
          'city':address.city,
          'name':address.name,
          'pincode':address.pincode,
        },
      ),
    );
    _items.insert(
        0,
        AddressItem(id: json.decode(response.body)['name'],addressLine1: address.addressLine1,addressLine2: address.addressLine2,city: address.city,name: address.name,pincode: address.pincode));
    notifyListeners();
  }

}