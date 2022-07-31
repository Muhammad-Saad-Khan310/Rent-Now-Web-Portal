import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/accounts.dart';
import '../widgets/userProfile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/user-profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<UserAccounts>(context).getUserProfile().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _refreshItem() async {
    // await Provider.of<UserAccounts>(context, listen: false).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshItem,
              child: FutureBuilder(
                future: _refreshItem(),
                builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<UserAccounts>(
                            builder: (ctx, renterData, _) => UserProfile(
                                renterData.accounts[0].id,
                                renterData.accounts[0].userName,
                                renterData.accounts[0].dateOfBirth,
                                renterData.accounts[0].phoneNumber,
                                renterData.accounts[0].address,
                                renterData.accounts[0].imageUrl),
                          ),
              ),
            ),
    );
  }
}
