import 'package:flutter/material.dart';
import 'package:jain_namkin/provider/auth_provider.dart';
import 'package:jain_namkin/widgets/address_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  var textBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(10),
  );


  @override
  Widget build(BuildContext context) {
    bool _edit = false;
    final _last = Provider.of<Auth>(context,listen: false).last;
    final _first = Provider.of<Auth>(context,listen: false).first;
    final _mobile = Provider.of<Auth>(context,listen: false).mobile;
    final _email=Provider.of<Auth>(context,listen: false).email;
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
                  'Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'url',
                    ),
                    radius: 50,
                  ),
                  SizedBox(height: 20,),
                  Form(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 4,bottom: 8,right: 4),
                              child: TextFormField(
                                enabled: _edit,
                                initialValue: _first,
                                decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(color: Colors.redAccent),
                                    disabledBorder: textBorder,
                                    enabledBorder: textBorder),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 4, bottom: 8),
                              child: TextFormField(
                                enabled: _edit,
                                initialValue: _last,
                                decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(color: Colors.redAccent),
                                    disabledBorder: textBorder,
                                    enabledBorder: textBorder),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 4, bottom: 8),
                        child: TextFormField(
                          enabled: _edit,
                          initialValue: _mobile,
                          decoration: InputDecoration(
                              labelText: 'Mobile no',
                              labelStyle: TextStyle(color: Colors.redAccent),
                              disabledBorder: textBorder,
                              enabledBorder: textBorder),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 4, bottom: 8),
                        child: TextFormField(
                          enabled: false,
                          initialValue: _email,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.redAccent),
                              disabledBorder: textBorder,
                              enabledBorder: textBorder),
                        ),
                      ),
                    ],
                  ),
                  ),
                  AddressWidget(),
                  InkWell(onTap:(){Navigator.of(context).pushNamed('/orderScreen');},child: Card(child: ListTile(leading: Icon(Icons.payment),title: Text('orders'),),)),
                  Card(child: ListTile(leading: Icon(Icons.exit_to_app),title: Text('Logout'),onTap: (){Provider.of<Auth>(context,listen: false).logout();},),),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
