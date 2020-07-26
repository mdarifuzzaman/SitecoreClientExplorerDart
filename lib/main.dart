import 'package:SitecoreClientExplorer/components/home.dart';
import 'package:SitecoreClientExplorer/helpers/helper.dart';
import 'package:SitecoreClientExplorer/helpers/widgets.dart';
import 'package:SitecoreClientExplorer/services/sitecoreApi.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      title: "Sitecore client explorer",
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePagePageState createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePage> {
  TextEditingController _usernameEditingController =
      new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  final _sitecoreApi = new SitecoreApi();

  void loginClicked() {
    setState(() {
      if (formKey.currentState.validate()) {
        _loading = true;
        _sitecoreApi
            .loginToSitecore(_usernameEditingController.text,
                _passwordEditingController.text)
            .then((value) {
          setState(() {
            _loading = false;
            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConst.APPLICATION_TITLE),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/pictures/screen.png"),
                fit: BoxFit.fitHeight),
          ),
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 2 - 150),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            validator: (value) {
                              return value.isEmpty
                                  ? "Username cannot be empty."
                                  : null;
                            },
                            controller: _usernameEditingController,
                            decoration: simpleTextDecoration("Enter User Name"),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        TextFormField(
                          validator: (value) {
                            return value.isEmpty
                                ? "Password cannot be empty."
                                : null;
                          },
                          controller: _passwordEditingController,
                          decoration: simpleTextDecoration("Enter Password"),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            loginClicked();
                          },
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightBlueAccent),
                            child: Text(
                              "Login to Sitecore",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
