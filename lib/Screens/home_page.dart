import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jain_namkin/provider/auth_provider.dart';
import 'package:jain_namkin/provider/product_provider.dart';
import 'package:jain_namkin/views/cart_view.dart';
import 'package:jain_namkin/views/home_view.dart';
import 'package:jain_namkin/views/offers_view.dart';
import 'package:jain_namkin/views/profiles_view.dart';
import 'package:jain_namkin/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [HomeView(), CartView(), OffersView(), ProfileView()];

  bool _isInit = true;
  bool _isLoading = false;
  bool _isCategory = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
//    if(_isInit){
//      Provider.of<Products>(context).fetchAndSetProduct();
//    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTap(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              children: _screens,
              onPageChanged: _onPageChanged,
            ),
      bottomNavigationBar: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GNav(
            gap: 8,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            iconSize: 22,
            activeColor: Colors.white,
            duration: Duration(
              milliseconds: 700,
            ),
            tabBackgroundColor: Colors.grey[700],
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'cart',
              ),
              GButton(
                icon: Icons.local_offer,
                text: 'offer',
              ),
              GButton(
                icon: Icons.perm_identity,
                text: 'Profile',
              ),
            ],
            onTabChange: _onTap,
            selectedIndex: _selectedIndex,
          ),
        ),
      )),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            ListTile(
              title: Text(
                '${Provider.of<Auth>(context, listen: false).first} ${Provider.of<Auth>(context, listen: false).last}',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: Text(
                '${Provider.of<Auth>(context, listen: false).email}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: CircleAvatar(
                child: Icon(
                  Icons.perm_identity,
                  color: Colors.grey[100],
                ),
                radius: 40,
              ),
            ),
            Divider(
              height: 32,
              thickness: 0.5,
              color: Colors.grey[400],
              indent: 12,
              endIndent: 12,
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                _pageController.jumpToPage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Cart'),
              leading: Icon(Icons.shopping_cart),
              onTap: () {
                _pageController.jumpToPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Offers'),
              leading: Icon(Icons.local_offer),
              onTap: () {
                _pageController.jumpToPage(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('profile'),
              leading: Icon(Icons.perm_identity),
              onTap: () {
                _pageController.jumpToPage(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Category'),
              leading: Icon(Icons.perm_identity),
              trailing: _isCategory?Icon(Icons.remove):Icon(Icons.add),
              onTap: () {
                setState(() {
                  _isCategory = !_isCategory;
                });
              },
            ),
            if (_isCategory)
              Container(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('categoryScreen', arguments: 'bakery');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/15,right: 4,bottom: 4),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2020/05/01/09/13/cupcakes-5116009_960_720.jpg',
                              ),
                              radius: 10,
                            ),
                            Text('Bakery'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('categoryScreen', arguments: 'sweet');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/15,right: 4,bottom: 4),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2014/12/22/12/33/sweets-577230_960_720.jpg'),
                              radius: 10,
                            ),
                            Text('Sweets')
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){Navigator.of(context).pushNamed('categoryScreen',arguments: 'farsan');},
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/15,right: 4,bottom: 4),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/05/06/19/20/indian-2290593_960_720.jpg'),
                              radius: 10,
                            ),
                            Text('Farsan'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Provider.of<Auth>(context,listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
