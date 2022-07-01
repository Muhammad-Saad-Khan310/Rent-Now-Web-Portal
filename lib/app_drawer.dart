import 'package:flutter/material.dart';

// import './home/all_item_widget.dart';
import 'screens/all_item.dart';
import './screens/user_account.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void _showErrorDialog(String message, ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert!"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              ;
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 0),
            alignment: Alignment.center,
            color: Colors.teal,
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 105,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mike-b-170811.jpg&fm=jpg"),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Ahmed Ali",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Divider(),
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
          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.add_box,
              size: 35,
              color: Colors.teal,
            ),
            title: const Text("User Accounts"),
            onTap: () {
              Navigator.of(context).pushNamed(AllAccounts.routeName);
            },
          ),
          const Divider(),

          ListTile(
              leading: const Icon(
                Icons.person,
                size: 35,
                color: Colors.teal,
              ),
              title: const Text("Update Profile"),
              onTap: () {}),
          // ListTile(
          //   leading: const Icon(
          //     Icons.person_add,
          //     size: 35,
          //     color: Colors.teal,
          //   ),
          //   title: const Text("SignUp"),
          //   onTap: () {},
          // ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.login,
              size: 35,
              color: Colors.teal,
            ),
            title: const Text("Login"),
            onTap: () {},
          ),
          // const Divider(),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 35,
              color: Colors.teal,
            ),
            title: const Text("Logout"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
