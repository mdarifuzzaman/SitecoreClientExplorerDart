import 'package:SitecoreClientExplorer/components/details.dart';
import 'package:SitecoreClientExplorer/helpers/helper.dart';
import 'package:SitecoreClientExplorer/models/appmodel.dart';
import 'package:SitecoreClientExplorer/services/sitecoreApi.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool _loadingHomeItem = true;
  List<ItemModel> _data;
  final _sitecoreApi = new SitecoreApi();
  @override
  void initState() {
    super.initState();
    _sitecoreApi.getItem(AppConst.HOME_ITEM).then((value) {
      _data = value;
      if(_data == null)
      {
        //do somthing here
      }
      else{
          setState(() {
          _loadingHomeItem = false;
          });
      }
      
    });
  }

  void _navigateToHome(){
    _sitecoreApi.getChildItems(AppConst.HOME_ITEM).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(
        items: value,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConst.APPLICATION_TITLE),
      ),
      body: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/pictures/screen.png"),
                fit: BoxFit.fitHeight),
          ),
          child: _loadingHomeItem
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 3),
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Loading home, Please wait..",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: (){
                    _navigateToHome();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 3),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 300,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.cyan),
                          child: Text(
                            "Home",
                            style: TextStyle(fontSize: 20),
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
