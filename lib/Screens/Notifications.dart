import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/notifications_bloc.dart';

import 'LoginScreen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NotificationsBloc>(context).add(GetNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
        ),
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
          if (state is NotificationsReady) {
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black.withOpacity(0.7)),
                          top: BorderSide(color: Colors.black.withOpacity(0.7)),
                          left:
                              BorderSide(color: Colors.black.withOpacity(0.7)),
                          right: BorderSide(
                              color: Colors.black.withOpacity(0.7)))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Color.fromARGB(255, 209, 69, 14),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(state.notifications[index].message,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(state.notifications[index].createdAt),
                    ],
                  ),
                );
              },
              //   separatorBuilder: (context, index) => const Divider(),
            );
          } else if (state is NotificationsFailed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                btnOkColor: Colors.black,
                title: 'Sign in Required',
                desc: 'This action required to Sign in',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ).show();
            });
            return const Center(
              child: Text("No notifications yet"),
            );
          } else {
            return const Center(
              child: Text("No notifications yet"),
            );
          }
        }));
  }
}
