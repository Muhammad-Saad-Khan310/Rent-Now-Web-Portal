import 'package:adminportal/provider/auth.dart';
import 'package:adminportal/widgets/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/all_item.dart';
import './screens/user_account.dart';

import './widgets/item_detail.dart';
import './widgets/account_detail.dart';
import './widgets/practice.dart';
import './widgets/all_item_widget.dart';
import './screens/login.dart';
import './screens/profile_screen.dart';
import './widgets/update_admin.dart';

import './provider/items.dart';
import './provider/auth.dart';
import './provider/accounts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Items>(
          create: (ctx) => Items(""),
          update: (ctx, auth, previousData) => Items(
            auth.token ?? "",
            // previousData == null ? [] : previousData.accounts
          ),
        ),
        ChangeNotifierProxyProvider<Auth, UserAccounts>(
          create: (ctx) => UserAccounts("", "", []),
          update: (ctx, auth, previousData) => UserAccounts(
              auth.userId ?? "",
              auth.token ?? "",
              previousData == null ? [] : previousData.accounts),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Portal',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // home: AllItem(),
        home: const Login(),
        routes: {
          ItemDetail.routeName: (ctx) => ItemDetail(),
          AllItem.routeName: (ctx) => AllItem(),
          AccountDetail.routeName: (ctx) => const AccountDetail(),
          AllAccounts.routeName: (ctx) => AllAccounts(),
          Login.routeName: (context) => const Login(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          UpdateAdmin.routeName: (context) => const UpdateAdmin(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});


//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }


