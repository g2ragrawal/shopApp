import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jain_namkin/model/address_item.dart';
import 'package:jain_namkin/model/search_model.dart';
import 'package:jain_namkin/provider/address_provider.dart';
import 'package:jain_namkin/provider/auth_provider.dart';
import 'package:jain_namkin/provider/cart_provider.dart';
import 'package:jain_namkin/provider/order_provider.dart';
import 'package:jain_namkin/widgets/cart_card.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  bool _isInit = true;
  bool _isLoading = false;
  bool _isAddressEmpty=true;
  String _currentValueSelected='';
  List<String> Address=[];
  AddressProvider addressProvider;


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
      Provider.of<AddressProvider>(context).fetchAndSetAddress().then((_) {setState(() {
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
    addressProvider = Provider.of<AddressProvider>(context);
    if(addressProvider.items.length>0){
      Address=[];
      _isAddressEmpty=false;
      for(AddressItem item in addressProvider.items){Address.add(item.name);}
    _currentValueSelected=Address[0];
    }
    var cartItems = Provider.of<Cart>(context);
    var orderProvider = Provider.of<OrderProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                          Icons.menu,
                          color: Colors.black,
                        ),
                        padding: const EdgeInsets.all(0),
                        onPressed: () {Scaffold.of(context).openDrawer();}),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  'Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    }),
              ],
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(bottom: 8, right: 8, left: 8),
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => CartCard(
                        cartItem: cartItems.items.values.toList()[index],
                      ),
                      itemCount: cartItems.items.length,
                    ))),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Total Cart Value :'),
                      Text(cartItems.totalValue().toString()),
                    ],
                  ),
                 _isLoading?Center(child: CircularProgressIndicator()): _isAddressEmpty?FlatButton(
                    onPressed: () {Navigator.of(context).pushNamed('/addAddress');},
                    child: Text(
                      'Add Address',
                    ),color: Colors.amber,):DropdownButton<String>(
                    items: Address
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
                  FlatButton(
                    onPressed: cartItems.totalValue() == 0 || _isAddressEmpty ? null : () async{
                      setState(() {
                        _isLoading=true;
                      });
                      await orderProvider.addOrders(cartItems.items.values.toList(), cartItems.totalValue(), Provider.of<Auth>(context,listen: false).userId,_currentValueSelected,'pending');
                      setState(() {
                        _isLoading=false;
                      });
                      cartItems.clear();
                    },
                    child: cartItems.totalValue() == 0
                        ? Text('Add some Items')
                        : Text("Place Order"),
                    disabledColor: Colors.grey,
                    color: Colors.amber,
                  )
                ],
              ),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              margin: EdgeInsets.all(8),
            ),
          ],
        ),
      ),
    );
  }
}
