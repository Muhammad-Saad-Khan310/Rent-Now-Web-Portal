import 'package:adminportal/widgets/all_accounts_widget.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import '../provider/accounts.dart';
import 'package:provider/provider.dart';

class AllAccounts extends StatefulWidget {
  // const MyWidget({super.key});
  static const routeName = "/all_accounts";

  AllAccounts({super.key});

  @override
  State<AllAccounts> createState() => _AllAccountsState();
}

class _AllAccountsState extends State<AllAccounts> {
  var _isInit = true;

  var _isLoading = false;

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

      // Provider.of<UserAccounts>(context).fetchAndSetAccounts(false).then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final accountData = Provider.of<UserAccounts>(context);
    final account = accountData.accounts;
    return Scaffold(
      appBar: AppBar(title: const Text("Home page")),
      // drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                        itemCount: account.length,
                        itemBuilder: (ctx, int i) {
                          return AllAccountsWidget(
                              id: account[i].id,
                              userName: account[i].userName,
                              dateOfBirth: account[i].dateOfBirth,
                              imageUrl: account[i].imageUrl,
                              address: account[i].address,
                              contactNumber: account[i].phoneNumber);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
