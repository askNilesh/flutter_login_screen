import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        accentColor: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(microseconds: 1500));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.bounceIn);

    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();
  }

  final _formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailTextController.dispose();
    passTextController.dispose();
    super.dispose();
  }

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  Color emailColor, passwordColor;
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    _emailFocusNode.addListener(() {
      setState(() {
        emailColor = _emailFocusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        passwordColor = _passwordFocusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });

    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100.0,
              ),
              new Form(
                key: _formKey,
                child: new Theme(
                    data: ThemeData(
                        accentColor: Colors.purple,
                        primaryColor: Colors.blue,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 20.0,
                        ))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            focusNode: _emailFocusNode,
                            controller: emailTextController,
                            style: TextStyle(color: Colors.blue),
                            decoration: new InputDecoration(
                                labelText: "Enter Email Address",
                                labelStyle: TextStyle(
                                  color: _emailFocusNode.hasFocus
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                border: UnderlineInputBorder()),
                            keyboardType: TextInputType.emailAddress,
                            validator: (String email) {
                              if (email.length == 0) {
                                return 'Please enter email address';
                              } else {
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  return 'Please enter valid email address';
                                } else {
                                  return null;
                                }
                              }
                            },
                            onSaved: (String val) {
                              _email = val;
                            },
                            onChanged: (text) {
                              _email = text;
                            },
                          ),
                          new TextFormField(
                            focusNode: _passwordFocusNode,
                            controller: passTextController,
                            style: TextStyle(color: Colors.blue),
                            decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                labelText: "Enter password",
                                labelStyle: TextStyle(
                                  color: _passwordFocusNode.hasFocus
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                border: UnderlineInputBorder()),
                            keyboardType: TextInputType.text,
                            obscureText: passwordVisible,
                            validator: (String pass) {
                              if (pass.length == 0) {
                                return 'Please enter password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          new Container(
                            margin: const EdgeInsets.only(top: 40.0),
                            child: new MaterialButton(
                              textColor: Colors.white,
                              minWidth: 250.0,
                              color: Colors.blue[400],
                              child: new Text("Login"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  debugPrint("Email Address -> " +
                                      emailTextController.text);

                                  debugPrint("Password  -> " +
                                      passTextController.text);
                                }
                              },
                              splashColor: Colors.redAccent[100],
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
