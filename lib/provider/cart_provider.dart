import 'package:flutter/material.dart';
import 'package:jain_namkin/model/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String,CartItem> _cartItems={} ;

  Map<String,CartItem> get items {
    return {..._cartItems};
  }

  void addItems(String productId,String title,var quantity, var weights, String imagePath){
    if(_cartItems.containsKey(productId)){
      int _tot=0;
      quantity.forEach((key,value){_tot+=value;});
      if(_tot==0){_cartItems.remove(productId);}
      else{
      _cartItems.update(productId, (existingItem) => CartItem(title: title,weights: weights,id: productId,quantity: quantity,imagePath : imagePath));}
      notifyListeners();
    }
    else{
      _cartItems.putIfAbsent(productId, () => CartItem(title: title,weights: weights,id: productId,quantity: quantity,imagePath : imagePath));
      notifyListeners();
    }
  }

  void removeItems(productId){
    _cartItems.remove(productId);
    notifyListeners();
  }



  double totalValue(){
    double sumCartPrice =0;
//    _cartItems.forEach((key,item) {sumCartPrice += item.price*item.quantity;});
//    return sumCartPrice;
  _cartItems.forEach((key, item) {
    item.quantity.forEach((key, value) {if(value>0){
      sumCartPrice+=value*item.weights[key];
    }});
  });
  return sumCartPrice;
  }



  void clear(){
    _cartItems={};
    notifyListeners();
  }
}