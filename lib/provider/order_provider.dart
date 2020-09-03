import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jain_namkin/model/cart_item.dart';
import 'package:jain_namkin/model/order_item.dart';
import 'package:http/http.dart' as http;
import 'package:jain_namkin/model/product_item.dart';

class OrderProvider with ChangeNotifier{
  List<OrderItem> _orders=[];
  final String authToken;
  final String userId;
  OrderProvider(this.authToken,this.userId,this._orders);

  List<OrderItem> get orders{
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> product, double total,String userId,String address,String status) async {
    final timeStamp = DateTime.now();
    var url = 'https://project_name.firebaseio.com/orders/$userId.json';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'total': total,
          'dateTime': timeStamp.toIso8601String(),
          'userId':userId,
          'string':address,
          'status': status,
          'items': product
              .map((cartItem) => {
            'id': cartItem.id,
            'title': cartItem.title,
            'imagePath': cartItem.imagePath,
            'weights': cartItem.weights,
            'quantity': cartItem.quantity,
          })
              .toList()
        },
      ),
    );
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            totalPrice: total,
            time: timeStamp,
            products: product,
        status: status,
        address: address,
        userId: userId));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    var url = 'https://project_name.firebaseio.com/orders/$userId.json';
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as Map<String, dynamic>;
    if(fetchedData == null ){return;}
    List<OrderItem> loadedOrders = [];
    fetchedData.forEach((orderId, order) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          totalPrice: order['total'],
          time: DateTime.parse(order['dateTime']),
          status: order['status'],
          products: (order['items'] as List<dynamic>)
              .map((item) => CartItem(
            title: item['title'],
            weights: item['weights'] as Map<String,dynamic>,
            quantity: item['quantity'] as Map<String,dynamic>,
            imagePath: item['imagePath'],
            id: item['id'],
          ))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders;
  }

  List<ProductItem> _suggestionList=[ProductItem(title: 'Gathiya',
    imageURL:
    'https://www.nehascookbook.com/wp-content/uploads/2020/04/Bhavnagari-gathiya-WS-500x500.jpg',id: '-MGDpqkyjNoJUYxeOQor'),ProductItem(title: 'jalebi',
    imageURL:
    'https://cdn.pixabay.com/photo/2015/06/23/05/23/fresh-jalebi-818316_960_720.jpg',id: '-MGDfSzs73U2cntRo0bC'),ProductItem(title: 'Papdi',
    imageURL:
    'https://www.nehascookbook.com/wp-content/uploads/2020/05/Papadi-ghathiya-WS.jpg',id: '-MFzTot0pOnxVOa9OAlj')];
  List<ProductItem> get suggestionList{
    return [..._suggestionList];
  }
//
//  Future<void> fetchAndSetSuggestions() async {
//    var url = 'https://jain-namkin.firebaseio.com/products.json';
//    try {
//      var url = 'https://jain-namkin.firebaseio.com/orders/$userId.json';
//      final response = await http.get(url);
//      final fetchedData = json.decode(response.body) as Map<String, dynamic>;
//      if(fetchedData == null ){return;}
//    } catch (error) {
//      print(error);
//    }
//  }

  List<ProductItem> _popularList=[ProductItem(title: 'Gathiya',
      imageURL:
      'https://www.nehascookbook.com/wp-content/uploads/2020/04/Bhavnagari-gathiya-WS-500x500.jpg',id: '-MGDpqkyjNoJUYxeOQor'),ProductItem(title: 'jalebi',
      imageURL:
      'https://cdn.pixabay.com/photo/2015/06/23/05/23/fresh-jalebi-818316_960_720.jpg',id: '-MGDfSzs73U2cntRo0bC'),ProductItem(title: 'Papdi',
      imageURL:
      'https://www.nehascookbook.com/wp-content/uploads/2020/05/Papadi-ghathiya-WS.jpg',id: '-MFzTot0pOnxVOa9OAlj')];
  List<ProductItem> get popularList{
    return [..._popularList];
  }

}