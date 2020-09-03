import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jain_namkin/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final product;

  ProductCard({this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with AutomaticKeepAliveClientMixin{
  var _currentValueSelected;
  bool _isButtonClicked = false;
  List _someList;
  Map<String,int> quantity=Map();


  @override
  bool get wantKeepAlive=>true;

  @override
  void initState() {
    _someList = widget.product.weights.keys.toList();
    this._currentValueSelected = _someList[0];
    for (var i=0;i<_someList.length;i++){quantity.putIfAbsent(_someList[i], () => 0);}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var cartItems=Provider.of<Cart>(context);
    if(cartItems.items.containsKey(widget.product.id)){
      quantity=cartItems.items[widget.product.id].quantity;
    }
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1),
          blurRadius: 3,
          spreadRadius: 2,),
      ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed('/productItem',arguments: widget.product.id);
              },
              child: Container(
                height: 120,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),image: DecorationImage(image: NetworkImage(widget.product.imageURL,),fit: BoxFit.fill),),
//              child: Image.network(
//                widget.product.imageURL,
//                fit: BoxFit.fill,
//              ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.product.title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      items: widget.product.weights.keys
                          .map<DropdownMenuItem<String>>((String e) =>
                          DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                          .toList(),
                      onChanged: (String newSelectedValue) {
                        setState(() {
                          _currentValueSelected = newSelectedValue;
                        });
                      },
                      value: _currentValueSelected,
                    ),
                    SizedBox(width: 8,),
                    _currentValueSelected == null ? Text('') : Text(
                        widget.product.weights[_currentValueSelected]
                            .toString()),
                  ],
                ),
                quantity[_currentValueSelected]!=0 ?Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: ButtonTheme(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                quantity[_currentValueSelected]+=1;
                                cartItems.addItems(widget.product.id, widget.product.title, quantity, widget.product.weights, widget.product.imageURL);
                              });
                            },
                            child: Text('+'),
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(quantity[_currentValueSelected].toString()),
                      SizedBox(width: 10,),
                      ClipOval(
                        child: ButtonTheme(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10.0),
                          child: FlatButton(
                            onPressed: () {
                              quantity[_currentValueSelected]-=1;
                              cartItems.addItems(widget.product.id, widget.product.title, quantity, widget.product.weights, widget.product.imageURL);
                            },
                            child: Text('-'),
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : FlatButton(onPressed: () {
                  setState(() {
                    _isButtonClicked=true;
                    quantity[_currentValueSelected]+=1;
                    cartItems.addItems(widget.product.id, widget.product.title, quantity, widget.product.weights, widget.product.imageURL);
                  });
                },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.amber),
                    padding: EdgeInsets.all(6),
                    child: Text('Add to Cart'),),),
              ],
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
