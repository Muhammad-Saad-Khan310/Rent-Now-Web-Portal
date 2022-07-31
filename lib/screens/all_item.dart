// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/accounts.dart';
import './user_reports_screen.dart';
import '../provider/auth.dart';
import '../widgets/all_item_widget.dart';
import './login.dart';
import './profile_screen.dart';
import '../provider/items.dart';

class AllItem extends StatefulWidget {
  static const routeName = "/all_item";

  const AllItem({super.key});

  @override
  State<AllItem> createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  var _isInit = true;
  var _isLoading = false;
  var _showEmptyMessage = false;
  var renter = [
    Account(
        id: "id",
        userName: "sad",
        imageUrl: "img",
        dateOfBirth: "4",
        address: "psh",
        phoneNumber: "48")
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<UserAccounts>(context).fetchRenter().then((_) {
          final renterData = Provider.of<UserAccounts>(context, listen: false);
          renter = renterData.accounts;
          setState(() {
            _isLoading = true;
          });
        });
        await Provider.of<Items>(context, listen: false)
            .fetchAndSetItems(false)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
          _showEmptyMessage = true;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // final List<Item> loadedItems = [
  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final itm = itemData.items;
    if (itm.isEmpty) {
      _showEmptyMessage = true;
    }
    final width = MediaQuery.of(context).size.width;
    var childHeight = 3 / 2;
    var showItem = 3;
    if (width <= 1317 && width >= 1172) {
      childHeight = 4 / 2;
      showItem = 2;
    } else if (width < 1172) {
      showItem = 1;
      childHeight = 2 / 4;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Admin Portal")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // margin: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  SideBar(renter[0].userName, renter[0].imageUrl, itm.length),
                  _showEmptyMessage
                      ? Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.3,
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Text(
                            "No Item Requests",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.78,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 600,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.all(10.0),
                                      itemCount: itm.length,
                                      itemBuilder: (ctx, int i) {
                                        return AllItemWidget(
                                            id: itm[i].id,
                                            title: itm[i].title,
                                            imageUrl: itm[i].imageUrl,
                                            price: itm[i].price,
                                            description: itm[i].description,
                                            address: itm[i].address,
                                            phoneNumber: itm[i].phoneNumber);
                                      },
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: showItem,
                                              childAspectRatio: childHeight,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}

class SideBar extends StatelessWidget {
  final String userName;
  final String imageUrl;
  final int totalRequest;
  const SideBar(this.userName, this.imageUrl, this.totalRequest, {super.key});
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context);
    void _showAdminImage(String image, ctx) {
      showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          content: Image.network(image),
        ),
      );
    }

    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 185, 189, 192)),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                width: 250,
                height: 265,
                decoration: const BoxDecoration(color: Colors.teal),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      CircleAvatar(
                        radius: 105,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () => _showAdminImage(imageUrl, context),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 35,
              color: Colors.teal,
            ),
            title: const Text("Item Request"),
            onTap: () async {
              Navigator.of(context).pushNamed(AllItem.routeName);
            },
          ),
          const Divider(
            color: Colors.teal,
          ),
          ListTile(
            leading: const Icon(
              Icons.add_box,
              size: 35,
              color: Colors.teal,
            ),
            title: const Text("User Reports"),
            onTap: () {
              Navigator.of(context).pushNamed(UserReportsScreen.routeName);
            },
          ),
          const Divider(color: Colors.teal),
          ListTile(
              leading: const Icon(
                Icons.person,
                size: 35,
                color: Colors.teal,
              ),
              title: const Text("Admin Profile"),
              onTap: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              }),
          const Divider(color: Colors.teal),
          userData.isAuth
              ? Container()
              : ListTile(
                  leading: const Icon(
                    Icons.login,
                    size: 35,
                    color: Colors.teal,
                  ),
                  title: const Text("Login"),
                  onTap: () {
                    Navigator.of(context).pushNamed(Login.routeName);
                  },
                ),
          userData.isAuth
              ? ListTile(
                  leading: const Icon(
                    Icons.logout,
                    size: 35,
                    color: Colors.teal,
                  ),
                  title: const Text("Logout"),
                  onTap: () {
                    userData.logout();
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
