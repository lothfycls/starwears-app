import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditMode = false;
  String _userName = "";

  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _adressController = TextEditingController();
  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _showDialog(errorMsg) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Changes were not saved',
      desc: errorMsg,
      btnOkColor: Colors.black,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    );
  }

  _showAlertDialog(errorMsg) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Changes were not saved',
      desc: errorMsg,
      btnOkColor: Colors.black,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show().then(
        (val) => BlocProvider.of<ProfileBloc>(context).add(InitProfile()));
  }

  _showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Changes were made with success',
      btnOkColor: Colors.black,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show().then(
        (val) => BlocProvider.of<ProfileBloc>(context).add(InitProfile()));
  }

  GlobalKey<FormState> passKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> usernameKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameController.text =
        BlocProvider.of<AuthenticationBloc>(context).firstName;
    _emailController.text = BlocProvider.of<AuthenticationBloc>(context).email!;
    _lastNameController.text =
        BlocProvider.of<AuthenticationBloc>(context).lastName;
    _userNameController.text = _userName;
    _phoneNumberController.text =
        BlocProvider.of<AuthenticationBloc>(context).phoneNumber;
    _adressController.text =
        BlocProvider.of<AuthenticationBloc>(context).homeAdress;
    _userNameController.text =
        BlocProvider.of<AuthenticationBloc>(context).username;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: (() {
              Navigator.of(context).pop();
            }),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 15,
                ),
                Text(
                  "Account",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        actions: <Widget>[
          BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is UpdateFailed) {
                _onWidgetDidBuild(_showAlertDialog(state.message));
              }

              if (state is UpdateSuccess) {
                _onWidgetDidBuild(_showSuccessDialog());
              }
            },
            builder: (context, state) => TextButton(
              child: _isEditMode
                  ? Text(
                      "Done",
                      style: TextStyle(color: Color.fromARGB(153, 0, 0, 0)),
                    )
                  : Text(
                      "Edit",
                      style: TextStyle(color: Colors.black),
                    ),
              onPressed: () {
                setState(() {
                  _isEditMode = !_isEditMode;
                  if (!_isEditMode) {
                    BlocProvider.of<ProfileBloc>(context).add(UpdateProfile(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        address: _adressController.text,
                        phone: _phoneNumberController.text,
                        username: _userNameController.text));
                  }
                });
              },
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "First Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: _isEditMode ? false : true,
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Last Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: _isEditMode ? false : true,
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "UserName",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: _isEditMode ? false : true,
                controller: _userNameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: _isEditMode ? false : true,
                controller: _emailController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Phone Number",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: _isEditMode ? false : true,
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Adress",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 5,
                readOnly: _isEditMode ? false : true,
                controller: _adressController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF6F6F6),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    TextEditingController oldController =
                        TextEditingController();
                    TextEditingController newController =
                        TextEditingController();
                    if (_isEditMode) {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        50),
                                child: SizedBox(
                                  child: Center(
                                    child: Form(
                                      key: passKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  // hintStyle: TextStyle(color: Colors.grey),
                                                  inputDecorationTheme:
                                                      InputDecorationTheme(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  obscureText: true,
                                                  controller: oldController,
                                                  validator: (value) =>
                                                      value!.isEmpty
                                                          ? "Enter a value"
                                                          : null,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "old password"),
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              child: Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    // hintStyle: TextStyle(color: Colors.grey),
                                                    inputDecorationTheme:
                                                        InputDecorationTheme(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    controller: newController,
                                                    validator: (value) =>
                                                        value!.isEmpty
                                                            ? "Enter a value"
                                                            : null,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "new password"),
                                                  ))),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          BlocConsumer<ProfileBloc,
                                              ProfileState>(
                                            listener: (context, state) {
                                              print(newController.text);
                                              if (state is PasswordFailed) {
                                                _onWidgetDidBuild(
                                                    _showAlertDialog(
                                                        state.message));
                                              }

                                              if (state is PasswordSuccess) {
                                                _onWidgetDidBuild(
                                                    _showSuccessDialog());
                                              }
                                            },
                                            builder: (context, state) =>
                                                FlatButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 100),
                                              color: Colors.black,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              onPressed: () async {
                                                if (passKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<ProfileBloc>(
                                                          context)
                                                      .add(UpdatePassword(
                                                          old: oldController
                                                              .text,
                                                          newPass: newController
                                                              .text));
                                                }
                                              },
                                              child: const Text(
                                                "Update",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: _isEditMode ? Colors.blue : Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    TextEditingController newEmail = TextEditingController();

                    if (_isEditMode) {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SizedBox(
                                  child: Center(
                                    child: Form(
                                      key: emailKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  // hintStyle: TextStyle(color: Colors.grey),
                                                  inputDecorationTheme:
                                                      InputDecorationTheme(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  controller: newEmail,
                                                  validator: (value) =>
                                                      value!.isEmpty
                                                          ? "Enter a value"
                                                          : null,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "New email"),
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          BlocConsumer<ProfileBloc,
                                              ProfileState>(
                                            listener: (context, state) {
                                              print("hello");
                                              if (state is EmailFailed) {
                                                _onWidgetDidBuild(
                                                    _showAlertDialog(
                                                        state.message));
                                              }

                                              if (state is EmailSuccess) {
                                                _onWidgetDidBuild(
                                                    _showSuccessDialog());
                                              }
                                            },
                                            builder: (context, state) =>
                                                FlatButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 100),
                                              color: Colors.black,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              onPressed: () async {
                                                if (emailKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<ProfileBloc>(
                                                          context)
                                                      .add(UpdateEmail(
                                                          email:
                                                              newEmail.text));
                                                }
                                              },
                                              child: const Text(
                                                "Update",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    "Change Email",
                    style: TextStyle(
                        color: _isEditMode ? Colors.blue : Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
