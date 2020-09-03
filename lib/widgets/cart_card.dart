import 'package:flutter/material.dart';
class CartCard extends StatelessWidget {
  final cartItem;
  Widget fetchAndSet(cartValue){
    List<Widget> weightsProduct=[];
    var keys =cartValue.weights.keys.toList();
    double totPrice=0;
    for(var i=0;i<keys.length;i++){
      if (cartValue.quantity[keys[i]]>0){
        String temp= keys[i]+'   ';
        temp+=cartValue.quantity[keys[i]].toString()+' x ';
        temp+=cartValue.weights[keys[i]].toString();
        totPrice+=cartValue.quantity[keys[i]]*cartValue.weights[keys[i]];
        weightsProduct.add(Text(temp,style: TextStyle(color: Colors.grey),));
        weightsProduct.add(SizedBox(height: 2,));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(children: weightsProduct,),
        SizedBox(width: 16,),
        Text(totPrice.toString()),
      ],
    );
  }
  CartCard({this.cartItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1),blurRadius: 2,spreadRadius: 3)],color: Colors.white,borderRadius: BorderRadius.circular(12)),margin: EdgeInsets.all(8),
      child: Row(children: <Widget>[Expanded(child: Image.network(cartItem.imagePath),flex: 1,),Expanded(child: Column(children: <Widget>[Text(cartItem.title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,),),SizedBox(height: 2,),fetchAndSet(cartItem),],),flex: 2,)],),
    );
  }
}