import 'package:flutter/material.dart';
import 'package:gadget_shop/data/user/user_model.dart';
import 'package:gadget_shop/screens/news/news_screen.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/users_view/users_view_model.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<UserViewModel>().getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<UserViewModel>().loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.red,
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                ...List.generate(
                  context.watch<UserViewModel>().users.length,
                  (index) {
                    UserModel userModel =
                        context.watch<UserViewModel>().users[index];
                    return ListTile(
                      title: Text(userModel.email),
                      subtitle: Text(userModel.password),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewsScreen();
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
