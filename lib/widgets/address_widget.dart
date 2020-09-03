import 'package:flutter/material.dart';
import 'package:jain_namkin/provider/address_provider.dart';
import 'package:jain_namkin/widgets/address_card.dart';
import 'package:provider/provider.dart';

class AddressWidget extends StatefulWidget {
  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  bool _expandAddress = false;


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
    var addressProvider = Provider.of<AddressProvider>(context);
    print(addressProvider.items.length);
    return _isLoading?CircularProgressIndicator():Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Manage Address'),
            trailing: IconButton(
              icon: _expandAddress
                  ? Icon(Icons.keyboard_arrow_up)
                  : Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                setState(() {
                  _expandAddress = !_expandAddress;
                });
              },
            ),
          ),
          if (_expandAddress)
            Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return AddressCard(
                    addressItem: addressProvider.items[index],
                  );
                },
                itemCount: addressProvider.items.length,
                shrinkWrap: true,
              ),
            ),
          ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: FlatButton(
              onPressed: () {Navigator.of(context).pushNamed('/addAddress');},
              child: Text(
                '+',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
