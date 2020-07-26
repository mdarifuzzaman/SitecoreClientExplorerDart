import 'package:SitecoreClientExplorer/helpers/helper.dart';
import 'package:SitecoreClientExplorer/helpers/widgets.dart';
import 'package:SitecoreClientExplorer/services/sitecoreApi.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final dynamic items;
  Details({@required this.items});

  @override
  _DetailsState createState() => _DetailsState(items: items);
}

class _DetailsState extends State<Details> {
  final dynamic items;
  final _sitecoreApi = new SitecoreApi();

  _DetailsState({@required this.items});

  @override
  void initState() {
    super.initState();
  }

  void listItemPressed(dynamic data) {
    print(data);
    _sitecoreApi.getChildItems(data["ItemID"]).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                    items: value,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        height: 60,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width - 5,
                        decoration: BoxDecoration(color: Colors.red),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
                              child: Text(
                                items[0]["ItemPath"],
                                style: TextStyle(
                                    color: Colors.black, 
                                    fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  customListItem(items, index, () {
                    listItemPressed(items[index]);
                  })
                ],
              );
            }
            return customListItem(items, index, () {
              listItemPressed(items[index]);
            });
          },
        ),
      ),
    );
  }
}
