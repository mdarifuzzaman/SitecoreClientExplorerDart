
import 'package:flutter/material.dart';

import 'helper.dart';

InputDecoration simpleTextDecoration(String hintText){
  return new InputDecoration(
     hintText: hintText,
    hintStyle: TextStyle(
        color: Colors.white70
    ),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    errorStyle: TextStyle(
      color: Colors.white
    )
  );
}

ListTile customListItem(dynamic items, int index, Function callback){
  return ListTile(
              onTap: () => callback(),
              leading: Image.network(AppConst.SCHEME + "://" + AppConst.HOST + items[index]["ItemIcon"]),
              title: Container(child: Row(
                children: <Widget>[
                  Text(items[index]["ItemName"],)
                ],
              )),
              subtitle:   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text( items[index]["TemplateID"]),
                  Text(items[index]["TemplateName"])
                ],
              ),
              //trailing: Text(items[index]["TemplateName"]),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            );
}