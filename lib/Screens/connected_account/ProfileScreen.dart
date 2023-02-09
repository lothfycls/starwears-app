import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/authentication_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditMode = false;
  String _firstName = "John";
  String _lastName = "John";
  String _userName = "John";
  String _email = "";
  String _phoneNumber = "+212612345678";
  String _adress = '''243 john doe street 
Sheffield Road
778U 5yd
London''';

  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _adressController = TextEditingController();

  @override
  void initState() {
    _email = BlocProvider.of<AuthenticationBloc>(context).email!;
    _firstNameController.text = _firstName;
    _emailController.text = _email;
    _lastNameController.text = _lastName;
    _userNameController.text = _userName;
    _phoneNumberController.text = _phoneNumber;
    _adressController.text = _adress;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        centerTitle: true,
        
        leading: Container(
          // color: Colors.red,
          padding: EdgeInsets.only(left: 10),
          // width: 100,
          // width: 200,
          child: InkWell(
            onTap: (() {
              Navigator.of(context).pop();
            }),
            child: Row(
              // mainAxisAlignment: M,
              children: <Widget>[
                // SizedBox(width: 5,),
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
          TextButton(
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
                  _firstNameController.text = _firstName;
                  _emailController.text = _email;
                  _lastNameController.text = _lastName;
                  _userNameController.text = _userName;
                  _phoneNumberController.text = _phoneNumber;
                  _adressController.text = _adress;
                }
              });
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: Text(
                    "Change Email",
                    style: TextStyle(
                        color: _isEditMode ? Colors.blue : Colors.black,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
