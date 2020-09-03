import 'package:flutter/material.dart';
import 'package:jain_namkin/model/address_item.dart';
import 'package:jain_namkin/provider/address_provider.dart';
import 'package:jain_namkin/widgets/button_widget.dart';
import 'package:jain_namkin/widgets/textfied_wigdet.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  List<int> validPincodes = [394578, 495845, 454545];
  bool _isvalidPincode = false;
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _form2 = GlobalKey();
  bool _isLoading=false;
  AddressItem address=AddressItem(id: '',addressLine2: '',addressLine1: '',city: '',name: '',pincode: '',);

  void checkValidPincode() {
    setState(() {
      _isvalidPincode =
          validPincodes.contains(int.parse(_passwordController.text));
    });
  }

  Future<void> _submit() async{
    if (!_form2.currentState.validate()) {
      return;
    }
    _form2.currentState.save();
    setState(() {
      _isLoading=true;
    });
    try {
      await Provider.of<AddressProvider>(context, listen: false).addAddress(address);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
        title: Text('An Error occured!'),
        content: Text('Something Went Wrong'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }
  setState(() {
    _isLoading=false;
  });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                    'Offers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: <Widget>[
                    Form(
                      key:_form2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Please enter your pincode',
                            style:
                                TextStyle(color: Colors.redAccent, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldWidget(
                            text: 'Pincode',
                            isObscuredText: false,
                            controller: _passwordController,
                            validator: (value) {
                              if (value.length != 6) {
                                return 'pincode length is 6';
                              }
                              return null;
                            },
                            onSaved: (value){
                              address=AddressItem(id: address.id,addressLine1: address.addressLine1,addressLine2: address.addressLine2,city: address.city,name: address.name,pincode: value);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          if (_isvalidPincode == false)
                            ButtonWidget(
                              text: 'Continue',
                              hasBorder: true,
                              clickFunction: checkValidPincode,
                            ),
                          if (_isvalidPincode)
                            Column(
                              children: <Widget>[
                                TextFieldWidget(
                                  text: 'AddressLine1',
                                  isObscuredText: false,
                                  validator: (value) {
                                    if (value == null||value.length==0) {
                                      return 'please enter';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    address=AddressItem(id: address.id,addressLine1: value,addressLine2: address.addressLine2,city: address.city,name: address.name,pincode: address.pincode);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFieldWidget(
                                  text: 'AddressLine2',
                                  isObscuredText: false,
                                  validator: (value) {
                                    if (value == null||value.length==0) {
                                      return 'please enter';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    address=AddressItem(id: address.id,addressLine1: address.addressLine1,addressLine2: value,city: address.city,name: address.name,pincode: address.pincode);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFieldWidget(
                                  text: 'name',
                                  isObscuredText: false,
                                  validator: (value) {
                                    if (value == null||value.length==0) {
                                      return 'please enter';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    address=AddressItem(id: address.id,addressLine1: address.addressLine1,addressLine2: address.addressLine2,city: address.city,name: value,pincode: address.pincode);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFieldWidget(
                                  text: 'city',
                                  isObscuredText: false,
                                  validator: (value) {
                                    if (value == null||value.length==0) {
                                      return 'please enter';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    address=AddressItem(id: address.id,addressLine1: address.addressLine1,addressLine2: address.addressLine2,city: value,name: address.name,pincode: address.pincode);
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _isLoading?CircularProgressIndicator():ButtonWidget(
                                  text: 'Save Address',
                                  hasBorder: true,
                                  clickFunction: _submit,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
