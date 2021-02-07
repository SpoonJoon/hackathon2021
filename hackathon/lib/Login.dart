import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/loginState.dart';

class SignUpPage extends StatelessWidget {

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  //INPUT FORM FOR EMAIL AND PASSWORD
  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width*0.03, right: size.width*0.03, top: size.height*0.02, bottom: size.height*0.02),
          child: Form(
            key: _formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle), labelText: "Bing Email"),
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@binghamton.edu").hasMatch(val) ? null : "Please input correct email";
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "Password",
                  ),
                  validator:  (val){
                    return val.length < 6 ? "Please enter password." : null;
                  },
                ),
                Container(
                  height: size.height * 0.01,
                ),
                Consumer<LoginState>(
                    builder: (context, value, child) => Opacity(
                      opacity: value.returningUser ? 0 : 1,
                      child: GestureDetector(
                          onTap: value.returningUser
                              ? null
                              : () {
                          },
                          child: Text("forgot password?", style: TextStyle(color: Colors.green[900]))),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(Size size) {
    return SizedBox(
      height: 50,
      width: size.width,

      child: Card(
        elevation: 6,
        child: Consumer<LoginState>(
          builder: (context, LoginState, child) => RaisedButton(
            child: Text(
              LoginState.returningUser ? 'Login' : 'Join',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Colors.green[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              if (_formState.currentState.validate()) {
                LoginState.returningUser ?  _login(context) : _register(context);
              }
              if (!_formState.currentState.validate()) {
                final snacBar = SnackBar(
                  content: Text('Email or password is wrong'),
                );
                Scaffold.of(context).showSnackBar(snacBar);
              }else{
                final snacBar = SnackBar(
                  content: Text('Success'),
                );
                Scaffold.of(context).showSnackBar(snacBar);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _signInorLogin() {
    return Consumer<LoginState>(
      builder: (context, LoginState, child) => GestureDetector(
        onTap: () {
          LoginState.toggle();
        },
        child: Text(
          LoginState.returningUser ?'Don\'t have an account? Make one!' : 'Have an account? Login!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }


  //Methods

  void _register(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void _login(BuildContext context) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    final User user = userCredential.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text('Account not found.'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/bing2.png'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        //backgroundColor: Colors.green[900],
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: size.height*0.6,),
              _inputForm(size),
              _loginButton(size),
              Container(height: size.height*0.02,),
              _signInorLogin()
            ],
          ),
        ),
      ),
    );
  }
}