import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missioning/pages/home.dart';

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Provide an email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
                onSaved: (input) => _email = input,
              ),
              TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Longer password please';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                onSaved: (input) => _password = input,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signUp,
                child: Text('Sign Up'),
              ),
            ],
          )
      ),
    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user: user,)));

      }catch(e){
        print(e.message);
      }
    }
  }
}
