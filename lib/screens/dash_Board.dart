// import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'package:provider/provider.dart';
// import '../provider/accounts.dart';
// import './all_item.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   var _isInit = true;
//   var _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       setState(() {
//         _isLoading = true;
//       });


//         Provider.of<UserAccounts>(context).fetchRenter().then((_) {
//           setState(() {
//             _isLoading = false;
//           });
//         });
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//      final renterData = Provider.of<UserAccounts>(context);
//     final renter = renterData.accounts;
//     return const SideBar(renter[0].userName);
//   }
// }
