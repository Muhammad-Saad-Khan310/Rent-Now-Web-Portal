import 'package:adminportal/provider/accounts.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../provider/item.dart';
import '../widgets/all_item_widget.dart';
import '../app_drawer.dart';
import './user_account.dart';
import './login.dart';
import './profile_screen.dart';
import '../provider/items.dart';

class AllItem extends StatefulWidget {
  // const AllItem({super.key});
  static const routeName = "/all_item";

  @override
  State<AllItem> createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  var _isInit = true;
  var _isLoading = false;
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
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // final List<Item> loadedItems = [
  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final itm = itemData.items;

    return Scaffold(
      appBar: AppBar(title: const Text("Admin Portal")),
      // drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                SideBar(renter[0].userName, renter[0].imageUrl, itm.length),
                Container(
                  width: 1100,
                  // height: 800,

                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            height: 600,
                            padding: const EdgeInsets.only(
                                top: 40.0, left: 20, right: 20, bottom: 20),
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
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3 / 2,
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
    );
  }
}

class SideBar extends StatelessWidget {
  // const SideBar({
  //   Key? key,
  // }) : super(key: key);
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
          // title: const Text("Alert!"),
          content: Container(child: Image.network(image)),
          // actions: [
          //   TextButton(
          //     child: const Text("Ok"),
          //     onPressed: () {
          //       ;
          //     },
          //   )
          // ],
        ),
      );
    }

    return Container(
      width: 250,
      height: double.infinity,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 185, 189, 192)),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                width: 250,
                height: 265,
                decoration: BoxDecoration(color: Colors.teal),
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
                            backgroundImage: NetworkImage(imageUrl
                                // "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg"
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   userName,
                      //   style: const TextStyle(fontWeight: FontWeight.bold),
                      // )
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
            title: totalRequest > 0
                ? Row(
                    children: [
                      const Text("Item Request"),
                      Text(
                        " ($totalRequest)",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  )
                : const Text("Item Request"),
            onTap: () async {
              Navigator.of(context).pushNamed(AllItem.routeName);
            },
          ),
          const Divider(
            color: Colors.teal,
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.add_box,
          //     size: 35,
          //     color: Colors.teal,
          //   ),
          //   title: const Text("User Accounts"),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(AllAccounts.routeName);
          //   },
          // ),
          // const Divider(color: Colors.teal),
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
