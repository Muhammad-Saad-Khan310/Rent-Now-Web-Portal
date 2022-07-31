import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/auth.dart';
import './provider/reporItem.dart';
import './provider/items.dart';
import './provider/accounts.dart';

import './screens/user_reports_screen.dart';
import './screens/all_item.dart';
import './screens/login.dart';
import './screens/profile_screen.dart';

import './widgets/emailForm.dart';
import './widgets/item_detail.dart';
import './widgets/update_admin.dart';

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
        ChangeNotifierProxyProvider<Auth, ReportItems>(
            create: (ctx) => ReportItems(""),
            update: (ctx, auth, previousData) => ReportItems(auth.token ?? "")),
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
        home: const Login(),
        routes: {
          ItemDetail.routeName: (ctx) => const ItemDetail(),
          AllItem.routeName: (ctx) => const AllItem(),
          Login.routeName: (ctx) => const Login(),
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          UpdateAdmin.routeName: (ctx) => const UpdateAdmin(),
          UserReportsScreen.routeName: (ctx) => const UserReportsScreen(),
          EmailForm.routeName: (ctx) => const EmailForm(),
        },
      ),
    );
  }
}
