import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jain_namkin/model/product_item.dart';
import 'package:jain_namkin/provider/cart_provider.dart';
import 'package:jain_namkin/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final productId = ModalRoute.of(context).settings.arguments as String;
  final loadedProduct = Provider.of<Products>(context)
      .item
      .firstWhere((product) => product.id == productId);
    return Scaffold(
      body: ProductDetailWidget(product: loadedProduct,),
    );
  }
}

class ProductDetailWidget extends StatefulWidget {
  final ProductItem product;
  ProductDetailWidget({this.product});
  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {

  var _currentValueSelected;
  bool _isButtonClicked = false;
  List _someList;
  Map<String,int> quantity=Map();


  @override
  void initState() {
    _someList = widget.product.weights.keys.toList();
    this._currentValueSelected = _someList[0];
    for (var i=0;i<_someList.length;i++){quantity.putIfAbsent(_someList[i], () => 0);}
  }


  @override
  Widget build(BuildContext context) {
    var cartItems=Provider.of<Cart>(context);
    if(cartItems.items.containsKey(widget.product.id)){
      quantity=cartItems.items[widget.product.id].quantity;
    }
    return SafeArea(child: Column(
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
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              'Jain-namkeen',
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 50,
            ),
          ],
        ),
        SizedBox(height: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Image.network(widget.product.imageURL),
                    )),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(top: 8, left: 15, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          widget.product.title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
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
                          SizedBox(width: 20,),
                          _currentValueSelected == null ? Text('') : Text(
                              widget.product.weights[_currentValueSelected]
                                  .toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.product.description == null
                          ? 'description'
                          : widget.product.description,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: quantity[_currentValueSelected]!=0 ?Container(
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
                ) : Center(
                  child: FlatButton(onPressed: () {
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
                ),
              ),
            ],
          ),
        ),
      ],
    ),);
  }
}

