
import 'dart:convert';

import 'package:SitecoreClientExplorer/helpers/helper.dart';
import 'package:SitecoreClientExplorer/models/appmodel.dart';
import 'package:http/http.dart' as http;

Map<String, String> headers = {"content-type": "text/json"};
Map<String, String> cookies = {};

class SitecoreApi{
 
  AppConst _applicationConst = new AppConst();

  Future<bool> loginToSitecore(String username, String password) async{
    String url = _applicationConst.buildSitecoreUrl();
    
    try{
      final response = await http.post(url, body: {"domain": "sitecore", "username": "$username", "password": "$password"});
      print(response);
      if(response.statusCode == 200){
        _updateCookie(response);
        return true;
      }
      return false;

    }catch(e){
      print(e);
    }
     return false;
    
  }

  Future<List<ItemModel>> getItem(String homeItem) async{
    String url = _applicationConst.buildSitecoreUrlById(homeItem);
    final items = new List<ItemModel>();
    try{
      final response = await http.get(url, headers: headers);
      _updateCookie(response);
      final jsonData = jsonDecode(response.body);
      final model = new ItemModel(jsonData["ItemID"], jsonData["ItemName"], jsonData["ItemPath"], jsonData["TemplateID"], jsonData["ItemIcon"], jsonData["HasChildren"].toString(), jsonData["TemplateName"]);
      print(jsonData);
      items.add(model);
      return items;
    }catch(e){
      print(e);
    }

    return null;
  }

  Future<dynamic> getChildItems(String itemId) async{
    String url = _applicationConst.buildSitecoreUrlById(itemId);
    url = "$url/children";
    try{
      final response = await http.get(url, headers: headers);
      _updateCookie(response);
      final jsonDatas = jsonDecode(response.body);
      return jsonDatas;
    }catch(e){
      print(e);
    }

    return null;
  }

  void _updateCookie(http.Response response) {
    String allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {

      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires')
          return;

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0)
        cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

}