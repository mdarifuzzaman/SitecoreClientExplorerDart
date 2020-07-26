
class AppConst{
  static const APPLICATION_TITLE = "Sitecore Client Explorer";
  static const SCHEME = "http";
  static const HOST = "192.168.20.3";
  static const URLENDPART = "sitecore/api/ssc/auth/login";
  static const URL_PART = "sitecore/api/ssc/item";
  static const HOME_ITEM = "{0DE95AE4-41AB-4D01-9EB0-67441B7C2450}";

  String buildSitecoreUrl(){
    return "$SCHEME://$HOST/$URLENDPART";
  }

  String buildSitecoreUrlById(String itemId){
    return "$SCHEME://$HOST/$URL_PART/$itemId";
  }

  String buildRelativeSitecoreUrl(String itemId){
    return "$SCHEME://$HOST/$URL_PART";
  }
}