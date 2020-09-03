import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jain_namkin/model/order_item.dart';
import 'package:jain_namkin/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  bool _isInit = true;
  bool _isLoading = false;
  bool _isAddressEmpty=true;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrderProvider>(context).fetchAndSetOrders().then((_) {setState(() {
        _isLoading=false;
      });});
    }
//    if(_isInit){
//      Provider.of<Products>(context).fetchAndSetProduct();
//    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List orders= Provider.of<OrderProvider>(context).orders;
    print(orders[0].products[0].weights.values.toList());
    return Scaffold(
      body: _isLoading?Center(child: CircularProgressIndicator()):SafeArea(child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                height: 32,
                width: 32,
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {Navigator.of(context).pop();}),
                ),
              ),
              Text(
                'Orders',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(itemBuilder: (ctx,index){ return OrderItemCard(item: orders[index],);},itemCount: orders.length,),
            ),
          ),
        ],
      )),
    );
  }
}

class OrderItemCard extends StatefulWidget {
  final OrderItem item;
  OrderItemCard({this.item});

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool _expanded=false;

  Widget fetchAndSet(cartValue){
    List<Widget> weightsProduct=[];
    var keys =cartValue.weights.keys.toList();
    double totPrice=0;
    for(var i=0;i<keys.length;i++) {
      if (cartValue.quantity[keys[i]] > 0) {
        String temp = keys[i] + '   ';
        temp += cartValue.quantity[keys[i]].toString() + ' x ';
        temp += cartValue.weights[keys[i]].toString();
        totPrice += cartValue.quantity[keys[i]] * cartValue.weights[keys[i]];
        weightsProduct.add(Text(temp, style: TextStyle(color: Colors.grey),));
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

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(
      children: <Widget>[
        Text(widget.item.status),
        ListTile(
          title: Text('\u20B9 ${widget.item.totalPrice}'),
          subtitle: Text(
            DateFormat("dd/MM/yyyy").format(widget.item.time),
          ),
          trailing: IconButton(
            icon: _expanded
                ? Icon(Icons.expand_less)
                : Icon(Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded) Container(
          height: 120,
          child: ListView.builder(
            itemCount:widget.item.products.length,
            itemBuilder: (context, ind) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(child: Text(widget.item.products[ind].title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,),overflow: TextOverflow.fade,),flex: 2,),SizedBox(height: 2,),
                      Expanded(child: Column(children: <Widget>[fetchAndSet(widget.item.products[ind]),],),flex: 4,),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),);
  }
}

