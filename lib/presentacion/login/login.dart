import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class IniciarSesion extends StatefulWidget {
  static const routeName = '/login';

  @override
  _IniciarSesionState createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  _logonwithfb() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.keyboard_backspace),
              alignment: Alignment.centerLeft,
              color: Colors.blue[900],
              iconSize: 45,
              onPressed: () {
                Navigator.pop(context);
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: GestureDetector(
        child: Column(
          children: [
            // Text()
            // SizedBox(
            //   height: 0,
            // ),
            Texto(),
            Login(),
          ],
        ),
      ),
    );
  }
}

class Texto extends StatelessWidget {
  String title = "Login";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: AlignmentDirectional(-0.9, 0.0),
      child: Text(
        'Welcome Login',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.blue[900],
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  // Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text("Login with Facebook"),
            onPressed: () async {
              bool _isloggedIn = false;
              Map user;
              final facebooklogin = FacebookLogin();
              // _logonwithfb();
              final result = await facebooklogin.logIn(['email']);
              switch (result.status) {
                case FacebookLoginStatus.loggedIn:
                  final token = result.accessToken.token;
                  final graphResponse = await http.get(
                      'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
                  final profile = JSON.jsonDecode(graphResponse.body);
                  print(profile);
                  setState(() {
                    user = profile;
                    _isloggedIn = true;
                  });
                  break;

                case FacebookLoginStatus.cancelledByUser:
                  setState(() {
                    _isloggedIn = false;
                  });
                  break;
                case FacebookLoginStatus.error:
                  setState(() {
                    _isloggedIn = false;
                  });
              }
            },
          ),
        ),
        Form(
          key: _form,
          child: Container(
            // constraints: BoxConstraints(maxWidth: 300, minWidth: 300),
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(height: 30),
                TextFormField(
                  controller: _email,
                  validator: (val) {
                    if (val.isEmpty) return 'Este campo es requerido';
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Correo'),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _pass,
                  obscureText: true,
                  validator: (val) {
                    if (val.isEmpty) return 'Este campo es requerido';
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Contraseña'),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    if (_form.currentState.validate()) {
                      if (_email.text == "prueba123@gmail.com" &&
                          _pass.text == "123456") {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Haz iniciado sesion"),
                          ),
                        );
                        Navigator.pushNamed(
                          context,
                          'routeName',
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Ups! Usuario y contraseña no conciden"),
                          ),
                        );
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Ups! error"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green,
                    ),
                    child: SizedBox(
                      child: Text(
                        'Ingresar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
