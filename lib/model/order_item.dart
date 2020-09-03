import 'package:jain_namkin/model/cart_item.dart';

class OrderItem{
  final String id;
  final double totalPrice;
  final String userId;
  final List<CartItem> products;
  final DateTime time;
  final String status;
  final String address;
  OrderItem({this.id,this.userId,this.products,this.time,this.totalPrice,this.address,this.status});
}